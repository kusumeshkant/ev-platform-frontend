import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../network/api_client.dart';
import '../storage/token_storage.dart';

final getIt = GetIt.instance;

void setupCoreInjection() {
  // Storage
  getIt.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(
      aOptions: AndroidOptions(encryptedSharedPreferences: true),
    ),
  );

  getIt.registerLazySingleton<TokenStorage>(
    () => TokenStorage(getIt()),
  );

  // Network
  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(getIt()),
  );
}
