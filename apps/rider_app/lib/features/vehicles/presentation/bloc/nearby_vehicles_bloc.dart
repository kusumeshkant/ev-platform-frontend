import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/vehicle_repository.dart';

// Events
sealed class NearbyVehiclesEvent extends Equatable {
  @override List<Object?> get props => [];
}
class LoadNearbyVehicles extends NearbyVehiclesEvent {
  final double lat, lng;
  LoadNearbyVehicles(this.lat, this.lng);
  @override List<Object?> get props => [lat, lng];
}
class RefreshNearbyVehicles extends NearbyVehiclesEvent {
  final double lat, lng;
  RefreshNearbyVehicles(this.lat, this.lng);
  @override List<Object?> get props => [lat, lng];
}

// States
sealed class NearbyVehiclesState extends Equatable {
  @override List<Object?> get props => [];
}
class NearbyVehiclesInitial extends NearbyVehiclesState {}
class NearbyVehiclesLoading extends NearbyVehiclesState {}
class NearbyVehiclesLoaded  extends NearbyVehiclesState {
  final List<Vehicle> vehicles;
  NearbyVehiclesLoaded(this.vehicles);
  @override List<Object?> get props => [vehicles];
}
class NearbyVehiclesError extends NearbyVehiclesState {
  final String message;
  NearbyVehiclesError(this.message);
  @override List<Object?> get props => [message];
}

// BLoC
class NearbyVehiclesBloc extends Bloc<NearbyVehiclesEvent, NearbyVehiclesState> {
  final VehicleRepository _repository;

  NearbyVehiclesBloc(this._repository) : super(NearbyVehiclesInitial()) {
    on<LoadNearbyVehicles>(_onLoad);
    on<RefreshNearbyVehicles>(_onRefresh);
  }

  Future<void> _onLoad(LoadNearbyVehicles event, Emitter<NearbyVehiclesState> emit) async {
    emit(NearbyVehiclesLoading());
    await _fetch(event.lat, event.lng, emit);
  }

  Future<void> _onRefresh(RefreshNearbyVehicles event, Emitter<NearbyVehiclesState> emit) async {
    await _fetch(event.lat, event.lng, emit);
  }

  Future<void> _fetch(double lat, double lng, Emitter<NearbyVehiclesState> emit) async {
    final result = await _repository.getNearbyVehicles(lat: lat, lng: lng);
    result.fold(
      (f) => emit(NearbyVehiclesError(f.message)),
      (v) => emit(NearbyVehiclesLoaded(v)),
    );
  }
}
