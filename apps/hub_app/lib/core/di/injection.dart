import 'package:core_flutter/core_flutter.dart';
import '../../features/fleet/data/repositories/fleet_repository_impl.dart';
import '../../features/fleet/data/datasources/fleet_remote_datasource.dart';
import '../../features/fleet/domain/repositories/fleet_repository.dart';

void configureDependencies() {
  setupCoreInjection();
  getIt.registerLazySingleton<FleetRemoteDataSource>(() => FleetRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<FleetRepository>(() => FleetRepositoryImpl(getIt()));
}
