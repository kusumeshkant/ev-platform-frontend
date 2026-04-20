import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/ride.dart';
import '../../domain/repositories/ride_repository.dart';

sealed class RideHistoryEvent extends Equatable {
  @override List<Object?> get props => [];
}
class LoadRideHistory extends RideHistoryEvent {}

sealed class RideHistoryState extends Equatable {
  @override List<Object?> get props => [];
}
class RideHistoryInitial  extends RideHistoryState {}
class RideHistoryLoading  extends RideHistoryState {}
class RideHistoryLoaded   extends RideHistoryState {
  final List<Ride> rides;
  RideHistoryLoaded(this.rides);
  @override List<Object?> get props => [rides.length];
}
class RideHistoryError extends RideHistoryState {
  final String message;
  RideHistoryError(this.message);
  @override List<Object?> get props => [message];
}

class RideHistoryBloc extends Bloc<RideHistoryEvent, RideHistoryState> {
  final RideRepository _repository;
  RideHistoryBloc(this._repository) : super(RideHistoryInitial()) {
    on<LoadRideHistory>(_onLoad);
  }
  Future<void> _onLoad(LoadRideHistory _, Emitter<RideHistoryState> emit) async {
    emit(RideHistoryLoading());
    final result = await _repository.getRideHistory();
    result.fold((f) => emit(RideHistoryError(f.message)), (rides) => emit(RideHistoryLoaded(rides)));
  }
}
