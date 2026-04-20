import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import '../error/exceptions.dart';
import '../error/failures.dart';
import '../utils/app_logger.dart';
import 'api_constants.dart';
import 'api_interceptor.dart';
import '../storage/token_storage.dart';

class ApiClient {
  late final Dio _dio;

  ApiClient(TokenStorage tokenStorage) {
    _dio = Dio(BaseOptions(
      baseUrl:        ApiConstants.baseUrl,
      connectTimeout: ApiConstants.timeout,
      receiveTimeout: ApiConstants.timeout,
      headers: {'Content-Type': 'application/json'},
    ));

    _dio.interceptors.addAll([
      AuthInterceptor(tokenStorage, _dio),
      LoggingInterceptor(),
    ]);
  }

  Future<Either<Failure, T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParams,
    required T Function(dynamic) mapper,
  }) => _execute(() => _dio.get(path, queryParameters: queryParams), mapper);

  Future<Either<Failure, T>> post<T>(
    String path, {
    dynamic data,
    required T Function(dynamic) mapper,
  }) => _execute(() => _dio.post(path, data: data), mapper);

  Future<Either<Failure, T>> put<T>(
    String path, {
    dynamic data,
    required T Function(dynamic) mapper,
  }) => _execute(() => _dio.put(path, data: data), mapper);

  Future<Either<Failure, T>> delete<T>(
    String path, {
    required T Function(dynamic) mapper,
  }) => _execute(() => _dio.delete(path), mapper);

  Future<Either<Failure, T>> _execute<T>(
    Future<Response> Function() call,
    T Function(dynamic) mapper,
  ) async {
    try {
      final response = await call();
      return Right(mapper(response.data));
    } on DioException catch (e) {
      return Left(_mapDioError(e));
    } catch (e, st) {
      AppLogger.error('Unexpected API error', e, st);
      return const Left(UnknownFailure());
    }
  }

  Failure _mapDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return const NetworkFailure('Connection timed out');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      default:
        final code    = e.response?.statusCode;
        final message = e.response?.data?['message'] as String?
            ?? e.message
            ?? 'Server error';
        if (code == 401) return AuthFailure(message,    statusCode: code);
        if (code != null && code >= 500) return ServerFailure(message, statusCode: code);
        return NetworkFailure(message, statusCode: code);
    }
  }
}
