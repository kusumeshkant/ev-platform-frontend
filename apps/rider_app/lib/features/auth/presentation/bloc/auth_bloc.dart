import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:core_flutter/core_flutter.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/send_otp.dart';
import '../../domain/usecases/verify_otp.dart';
import '../../domain/repositories/auth_repository.dart';

// ── Events ────────────────────────────────────────────────────────────────────
sealed class AuthEvent extends Equatable {
  @override List<Object?> get props => [];
}

class CheckAuthStatus extends AuthEvent {}

class RequestOtp extends AuthEvent {
  final String phone;
  RequestOtp(this.phone);
  @override List<Object?> get props => [phone];
}

class ConfirmOtp extends AuthEvent {
  final String phone;
  final String otp;
  ConfirmOtp(this.phone, this.otp);
  @override List<Object?> get props => [phone, otp];
}

class LogoutRequested extends AuthEvent {}

// ── States ────────────────────────────────────────────────────────────────────
sealed class AuthState extends Equatable {
  @override List<Object?> get props => [];
}

class AuthInitial        extends AuthState {}
class AuthLoading        extends AuthState {}
class AuthOtpSent        extends AuthState { final String phone; AuthOtpSent(this.phone); @override List<Object?> get props => [phone]; }
class AuthAuthenticated  extends AuthState { final User user; AuthAuthenticated(this.user); @override List<Object?> get props => [user.id]; }
class AuthUnauthenticated extends AuthState {}
class AuthError          extends AuthState { final String message; AuthError(this.message); @override List<Object?> get props => [message]; }

// ── BLoC ──────────────────────────────────────────────────────────────────────
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SendOtp    _sendOtp;
  final VerifyOtp  _verifyOtp;
  final AuthRepository _repository;

  AuthBloc({
    required SendOtp sendOtp,
    required VerifyOtp verifyOtp,
    required AuthRepository repository,
  })  : _sendOtp    = sendOtp,
        _verifyOtp  = verifyOtp,
        _repository = repository,
        super(AuthInitial()) {
    on<CheckAuthStatus>(_onCheck);
    on<RequestOtp>(_onRequestOtp);
    on<ConfirmOtp>(_onConfirmOtp);
    on<LogoutRequested>(_onLogout);
  }

  Future<void> _onCheck(CheckAuthStatus _, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _repository.getCurrentUser();
    result.fold(
      (f) => emit(AuthUnauthenticated()),
      (user) => user != null ? emit(AuthAuthenticated(user)) : emit(AuthUnauthenticated()),
    );
  }

  Future<void> _onRequestOtp(RequestOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _sendOtp(event.phone);
    result.fold(
      (f) => emit(AuthError(f.message)),
      (_) => emit(AuthOtpSent(event.phone)),
    );
  }

  Future<void> _onConfirmOtp(ConfirmOtp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final result = await _verifyOtp(event.phone, event.otp);
    result.fold(
      (f) => emit(AuthError(f.message)),
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> _onLogout(LogoutRequested _, Emitter<AuthState> emit) async {
    await _repository.logout();
    emit(AuthUnauthenticated());
  }
}
