import 'package:core_flutter/core_flutter.dart';
import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/data/datasources/auth_remote_datasource.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/vehicles/data/repositories/vehicle_repository_impl.dart';
import '../../features/vehicles/data/datasources/vehicle_remote_datasource.dart';
import '../../features/vehicles/domain/repositories/vehicle_repository.dart';
import '../../features/ride/data/repositories/ride_repository_impl.dart';
import '../../features/ride/data/datasources/ride_remote_datasource.dart';
import '../../features/ride/domain/repositories/ride_repository.dart';
import '../../features/wallet/data/repositories/wallet_repository_impl.dart';
import '../../features/wallet/data/datasources/wallet_remote_datasource.dart';
import '../../features/wallet/domain/repositories/wallet_repository.dart';

void configureDependencies() {
  // Core
  setupCoreInjection();

  // Auth
  getIt.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(getIt(), getIt()));

  // Vehicles
  getIt.registerLazySingleton<VehicleRemoteDataSource>(() => VehicleRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<VehicleRepository>(() => VehicleRepositoryImpl(getIt()));

  // Rides
  getIt.registerLazySingleton<RideRemoteDataSource>(() => RideRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<RideRepository>(() => RideRepositoryImpl(getIt()));

  // Wallet
  getIt.registerLazySingleton<WalletRemoteDataSource>(() => WalletRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl(getIt()));
}
