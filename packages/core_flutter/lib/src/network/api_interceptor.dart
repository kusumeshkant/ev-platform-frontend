import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import '../error/exceptions.dart';
import '../utils/app_logger.dart';

class AuthInterceptor extends Interceptor {
  final TokenStorage _tokenStorage;
  final Dio _dio;

  AuthInterceptor(this._tokenStorage, this._dio);

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await _tokenStorage.accessToken;
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        await _refresh();
        final token = await _tokenStorage.accessToken;
        final opts  = err.requestOptions;
        opts.headers['Authorization'] = 'Bearer $token';
        final response = await _dio.fetch(opts);
        return handler.resolve(response);
      } catch (_) {
        await _tokenStorage.clear();
        handler.reject(err);
        return;
      }
    }
    handler.next(err);
  }

  Future<void> _refresh() async {
    final refresh = await _tokenStorage.refreshToken;
    if (refresh == null) throw AuthException('No refresh token');
    final resp = await _dio.post(
      '/api/v1/auth/refresh',
      data: {'refreshToken': refresh},
    );
    await _tokenStorage.save(
      accessToken:  resp.data['accessToken']  as String,
      refreshToken: resp.data['refreshToken'] as String,
    );
  }
}

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.debug('→ ${options.method} ${options.path}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.debug('← ${response.statusCode} ${response.requestOptions.path}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error('✗ ${err.response?.statusCode} ${err.requestOptions.path}: ${err.message}');
    handler.next(err);
  }
}
