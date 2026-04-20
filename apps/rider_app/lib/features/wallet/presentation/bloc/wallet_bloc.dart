import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/wallet.dart';
import '../../domain/repositories/wallet_repository.dart';

sealed class WalletEvent extends Equatable { @override List<Object?> get props => []; }
class LoadWallet extends WalletEvent {}
class TopupWallet extends WalletEvent {
  final double amount; final String paymentId;
  TopupWallet(this.amount, this.paymentId);
  @override List<Object?> get props => [amount, paymentId];
}

sealed class WalletState extends Equatable { @override List<Object?> get props => []; }
class WalletInitial  extends WalletState {}
class WalletLoading  extends WalletState {}
class WalletLoaded   extends WalletState {
  final Wallet wallet;
  WalletLoaded(this.wallet);
  @override List<Object?> get props => [wallet.balance];
}
class WalletError    extends WalletState {
  final String message;
  WalletError(this.message);
  @override List<Object?> get props => [message];
}

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository _repository;
  WalletBloc(this._repository) : super(WalletInitial()) {
    on<LoadWallet>(_onLoad);
    on<TopupWallet>(_onTopup);
  }
  Future<void> _onLoad(LoadWallet _, Emitter<WalletState> emit) async {
    emit(WalletLoading());
    final r = await _repository.getWallet();
    r.fold((f) => emit(WalletError(f.message)), (w) => emit(WalletLoaded(w)));
  }
  Future<void> _onTopup(TopupWallet event, Emitter<WalletState> emit) async {
    final r = await _repository.topup(event.amount, event.paymentId);
    r.fold((f) => emit(WalletError(f.message)), (w) => emit(WalletLoaded(w)));
  }
}
