import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:brand_config/brand_config.dart';

import '../bloc/auth_bloc.dart';
import '../../../../../../core/di/injection.dart';
import '../../../../../../core/router/route_names.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final _controller = TextEditingController();
  final _formKey    = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(
        sendOtp:    getIt(),
        verifyOtp:  getIt(),
        repository: getIt(),
      ),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (ctx, state) {
          if (state is AuthOtpSent) {
            ctx.push(RouteNames.otp, extra: state.phone);
          } else if (state is AuthError) {
            EvSnackBar.show(ctx, state.message, type: EvSnackBarType.error);
          }
        },
        child: _PhoneView(controller: _controller, formKey: _formKey),
      ),
    );
  }
}

class _PhoneView extends StatelessWidget {
  final TextEditingController controller;
  final GlobalKey<FormState> formKey;
  const _PhoneView({required this.controller, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.screenPadding,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                Text(
                  'Welcome to\n${BrandConfig.current.appName}',
                  style: AppTypography.h1.copyWith(color: context.colors.textPrimary),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Enter your phone number to get started',
                  style: AppTypography.bodyLarge.copyWith(color: context.colors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.x4l),
                EvTextField(
                  label: 'Phone Number',
                  hint: 'Enter your 10-digit number',
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(10)],
                  prefixIcon: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    child: Text('+91', style: AppTypography.bodyLarge.copyWith(color: context.colors.textPrimary)),
                  ),
                  validator: (v) => v != null && v.length == 10 ? null : 'Enter a valid 10-digit number',
                ),
                const SizedBox(height: AppSpacing.x3l),
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (ctx, state) => EvButton(
                    label: 'Send OTP',
                    isLoading: state is AuthLoading,
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        ctx.read<AuthBloc>().add(RequestOtp(controller.text.trim()));
                      }
                    },
                  ),
                ),
                const Spacer(flex: 3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
