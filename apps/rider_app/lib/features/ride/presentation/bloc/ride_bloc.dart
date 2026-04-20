import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/ride.dart';
import '../../domain/repositories/ride_repository.dart';

// Events
sealed class RideEvent extends Equatable {
  @override List<Object?> get props => [];
}
class StartRide    extends RideEvent { final String vehicleId; StartRide(this.vehicleId); @override List<Object?> get props => [vehicleId]; }
class EndRide      extends RideEvent { final String rideId;    EndRide(this.rideId);      @override List<Object?> get props => [rideId]; }
class LoadActiveRide extends RideEvent {}

// States
sealed class RideState extends Equatable {
  @override List<Object?> get props => [];
}
class RideInitial   extends RideState {}
class RideLoading   extends RideState {}
class RideStarted   extends RideState { final Ride ride; RideStarted(this.ride); @override List<Object?> get props => [ride.id]; }
class RideActive    extends RideState { final Ride ride; RideActive(this.ride);  @override List<Object?> get props => [ride.id]; }
class RideCompleted extends RideState { final Ride ride; RideCompleted(this.ride); @override List<Object?> get props => [ride.id]; }
class RideNoActive  extends RideState {}
class RideError     extends RideState { final String message; RideError(this.message); @override List<Object?> get props => [message]; }

// BLoC
class RideBloc extends Bloc<RideEvent, RideState> {
  final RideRepository _repository;

  RideBloc(this._repository) : super(RideInitial()) {
    on<LoadActiveRide>(_onLoad);
    on<StartRide>(_onStart);
    on<EndRide>(_onEnd);
  }

  Future<void> _onLoad(LoadActiveRide _, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await _repository.getActiveRide();
    result.fold(
      (f) => emit(RideError(f.message)),
      (ride) => ride != null ? emit(RideActive(ride)) : emit(RideNoActive()),
    );
  }

  Future<void> _onStart(StartRide event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await _repository.startRide(event.vehicleId);
    result.fold(
      (f) => emit(RideError(f.message)),
      (ride) => emit(RideStarted(ride)),
    );
  }

  Future<void> _onEnd(EndRide event, Emitter<RideState> emit) async {
    emit(RideLoading());
    final result = await _repository.endRide(event.rideId);
    result.fold(
      (f) => emit(RideError(f.message)),
      (ride) => emit(RideCompleted(ride)),
    );
  }
}
