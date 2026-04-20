import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/vehicle.dart';
import '../../domain/repositories/vehicle_repository.dart';

sealed class VehicleDetailEvent extends Equatable {
  @override List<Object?> get props => [];
}
class LoadVehicleDetail extends VehicleDetailEvent {
  final String id;
  LoadVehicleDetail(this.id);
  @override List<Object?> get props => [id];
}

sealed class VehicleDetailState extends Equatable {
  @override List<Object?> get props => [];
}
class VehicleDetailInitial extends VehicleDetailState {}
class VehicleDetailLoading  extends VehicleDetailState {}
class VehicleDetailLoaded   extends VehicleDetailState {
  final Vehicle vehicle;
  VehicleDetailLoaded(this.vehicle);
  @override List<Object?> get props => [vehicle.id];
}
class VehicleDetailError extends VehicleDetailState {
  final String message;
  VehicleDetailError(this.message);
  @override List<Object?> get props => [message];
}

class VehicleDetailBloc extends Bloc<VehicleDetailEvent, VehicleDetailState> {
  final VehicleRepository _repository;
  VehicleDetailBloc(this._repository) : super(VehicleDetailInitial()) {
    on<LoadVehicleDetail>(_onLoad);
  }
  Future<void> _onLoad(LoadVehicleDetail event, Emitter<VehicleDetailState> emit) async {
    emit(VehicleDetailLoading());
    final result = await _repository.getVehicle(event.id);
    result.fold((f) => emit(VehicleDetailError(f.message)), (v) => emit(VehicleDetailLoaded(v)));
  }
}
