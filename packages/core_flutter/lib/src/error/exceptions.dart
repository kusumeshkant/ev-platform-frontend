class AppException implements Exception {
  final String message;
  final int? statusCode;
  const AppException(this.message, {this.statusCode});
  @override
  String toString() => 'AppException($statusCode): $message';
}

class NetworkException  extends AppException { const NetworkException(super.m, {super.statusCode}); }
class ServerException   extends AppException { const ServerException(super.m,  {super.statusCode}); }
class AuthException     extends AppException { const AuthException(super.m,    {super.statusCode}); }
class CacheException    extends AppException { const CacheException(super.m); }
