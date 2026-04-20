import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:core_flutter/core_flutter.dart';

import 'package:rider_app/features/auth/domain/entities/user.dart';
import 'package:rider_app/features/auth/domain/usecases/send_otp.dart';
import 'package:rider_app/features/auth/domain/usecases/verify_otp.dart';
import 'package:rider_app/features/auth/presentation/bloc/auth_bloc.dart';

class MockSendOtp extends Mock implements SendOtp {}
class MockVerifyOtp extends Mock implements VerifyOtp {}

void main() {
  late MockSendOtp mockSendOtp;
  late MockVerifyOtp mockVerifyOtp;

  const testPhone = '+919876543210';
  const testOtp = '123456';
  const testUser = User(
    id: 'user-1',
    phone: testPhone,
    role: UserRole.rider,
  );

  setUp(() {
    mockSendOtp = MockSendOtp();
    mockVerifyOtp = MockVerifyOtp();
    registerFallbackValue(testPhone);
    registerFallbackValue(testOtp);
  });

  group('AuthBloc — SendOtp', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthOtpSent] when sendOtp succeeds',
      build: () {
        when(() => mockSendOtp(any())).thenAnswer(
          (_) async => const Right(unit),
        );
        return AuthBloc(sendOtp: mockSendOtp, verifyOtp: mockVerifyOtp);
      },
      act: (bloc) => bloc.add(const SendOtpEvent(phone: testPhone)),
      expect: () => [
        const AuthLoading(),
        const AuthOtpSent(phone: testPhone),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when sendOtp fails',
      build: () {
        when(() => mockSendOtp(any())).thenAnswer(
          (_) async => const Left(ServerFailure('Network error')),
        );
        return AuthBloc(sendOtp: mockSendOtp, verifyOtp: mockVerifyOtp);
      },
      act: (bloc) => bloc.add(const SendOtpEvent(phone: testPhone)),
      expect: () => [
        const AuthLoading(),
        const AuthError(message: 'Network error'),
      ],
    );
  });

  group('AuthBloc — VerifyOtp', () {
    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthAuthenticated] when OTP is valid',
      build: () {
        when(() => mockVerifyOtp(any(), any())).thenAnswer(
          (_) async => const Right(testUser),
        );
        return AuthBloc(sendOtp: mockSendOtp, verifyOtp: mockVerifyOtp);
      },
      act: (bloc) => bloc.add(
        const VerifyOtpEvent(phone: testPhone, otp: testOtp),
      ),
      expect: () => [
        const AuthLoading(),
        const AuthAuthenticated(user: testUser),
      ],
    );

    blocTest<AuthBloc, AuthState>(
      'emits [AuthLoading, AuthError] when OTP is invalid',
      build: () {
        when(() => mockVerifyOtp(any(), any())).thenAnswer(
          (_) async => const Left(AuthFailure('Invalid OTP')),
        );
        return AuthBloc(sendOtp: mockSendOtp, verifyOtp: mockVerifyOtp);
      },
      act: (bloc) => bloc.add(
        const VerifyOtpEvent(phone: testPhone, otp: '000000'),
      ),
      expect: () => [
        const AuthLoading(),
        const AuthError(message: 'Invalid OTP'),
      ],
    );
  });
}
