import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';

import '../bloc/auth_bloc.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/router/route_names.dart';

class OtpScreen extends StatefulWidget {
  final String phone;
  const OtpScreen({super.key, required this.phone});
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _otp = '';
  int _countdown = 60;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() => _countdown = 60);
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_countdown == 0) { t.cancel(); return; }
      if (mounted) setState(() => _countdown--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(sendOtp: getIt(), verifyOtp: getIt(), repository: getIt()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (ctx, state) {
          if (state is AuthAuthenticated) {
            ctx.go(RouteNames.home);
          } else if (state is AuthError) {
            EvSnackBar.show(ctx, state.message, type: EvSnackBarType.error);
          }
        },
        child: Scaffold(
          backgroundColor: context.colors.background,
          appBar: EvAppBar(title: 'Verify Phone', showBack: true),
          body: SafeArea(
            child: Padding(
              padding: AppSpacing.screenPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.x3l),
                  Text('Enter OTP', style: AppTypography.h2.copyWith(color: context.colors.textPrimary)),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'We sent a 6-digit code to +91 ${widget.phone}',
                    style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.x3l),
                  EvOtpField(
                    onCompleted: (otp) => setState(() => _otp = otp),
                    onChanged:   (otp) => setState(() => _otp = otp),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Center(
                    child: _countdown > 0
                        ? Text('Resend OTP in ${_countdown}s',
                            style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary))
                        : BlocBuilder<AuthBloc, AuthState>(
                            builder: (ctx, _) => EvButton.text(
                              label: 'Resend OTP',
                              onPressed: () {
                                ctx.read<AuthBloc>().add(RequestOtp(widget.phone));
                                _startTimer();
                              },
                            ),
                          ),
                  ),
                  const Spacer(),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (ctx, state) => EvButton(
                      label: 'Verify OTP',
                      isLoading: state is AuthLoading,
                      onPressed: _otp.length == 6
                          ? () => ctx.read<AuthBloc>().add(ConfirmOtp(widget.phone, _otp))
                          : null,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
