import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core_flutter/core_flutter.dart';

import 'package:rider_app/features/vehicles/domain/entities/vehicle.dart';
import 'package:rider_app/features/vehicles/domain/repositories/vehicle_repository.dart';
import 'package:rider_app/features/vehicles/presentation/bloc/nearby_vehicles_bloc.dart';

class MockVehicleRepository extends Mock implements VehicleRepository {}

final tVehicles = [
  Vehicle(
    id: 'v-1',
    model: 'Ather 450X',
    batteryLevel: 90,
    distanceMeters: 150,
    ratePerMinute: 2.5,
    status: VehicleStatus.available,
    location: const VehicleLocation(12.935, 77.624),
  ),
  Vehicle(
    id: 'v-2',
    model: 'Ola S1 Pro',
    batteryLevel: 70,
    distanceMeters: 350,
    ratePerMinute: 2.0,
    status: VehicleStatus.available,
    location: const VehicleLocation(12.936, 77.625),
  ),
];

void main() {
  late MockVehicleRepository mockRepo;

  setUp(() {
    mockRepo = MockVehicleRepository();
  });

  group('NearbyVehiclesBloc', () {
    blocTest<NearbyVehiclesBloc, NearbyVehiclesState>(
      'emits [NearbyVehiclesLoading, NearbyVehiclesLoaded] on success',
      build: () {
        when(() => mockRepo.getNearbyVehicles(
          lat: any(named: 'lat'),
          lng: any(named: 'lng'),
          radiusKm: any(named: 'radiusKm'),
        )).thenAnswer((_) async => Right(tVehicles));
        return NearbyVehiclesBloc(repository: mockRepo);
      },
      act: (bloc) => bloc.add(
        const LoadNearbyVehicles(lat: 12.935, lng: 77.624),
      ),
      expect: () => [
        const NearbyVehiclesLoading(),
        NearbyVehiclesLoaded(vehicles: tVehicles),
      ],
    );

    blocTest<NearbyVehiclesBloc, NearbyVehiclesState>(
      'emits [NearbyVehiclesLoading, NearbyVehiclesError] on failure',
      build: () {
        when(() => mockRepo.getNearbyVehicles(
          lat: any(named: 'lat'),
          lng: any(named: 'lng'),
          radiusKm: any(named: 'radiusKm'),
        )).thenAnswer((_) async => const Left(NetworkFailure('No connection')));
        return NearbyVehiclesBloc(repository: mockRepo);
      },
      act: (bloc) => bloc.add(
        const LoadNearbyVehicles(lat: 12.935, lng: 77.624),
      ),
      expect: () => [
        const NearbyVehiclesLoading(),
        const NearbyVehiclesError(message: 'No connection'),
      ],
    );

    blocTest<NearbyVehiclesBloc, NearbyVehiclesState>(
      'emits empty list when no vehicles nearby',
      build: () {
        when(() => mockRepo.getNearbyVehicles(
          lat: any(named: 'lat'),
          lng: any(named: 'lng'),
          radiusKm: any(named: 'radiusKm'),
        )).thenAnswer((_) async => const Right([]));
        return NearbyVehiclesBloc(repository: mockRepo);
      },
      act: (bloc) => bloc.add(
        const LoadNearbyVehicles(lat: 0, lng: 0),
      ),
      expect: () => [
        const NearbyVehiclesLoading(),
        const NearbyVehiclesLoaded(vehicles: []),
      ],
    );
  });
}
