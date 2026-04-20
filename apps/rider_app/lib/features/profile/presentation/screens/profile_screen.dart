import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/router/route_names.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(sendOtp: getIt(), verifyOtp: getIt(), repository: getIt())..add(CheckAuthStatus()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (ctx, state) {
          if (state is AuthUnauthenticated) ctx.go(RouteNames.phone);
        },
        child: Scaffold(
          backgroundColor: context.colors.background,
          appBar: EvAppBar(title: 'Profile', showBack: false),
          body: BlocBuilder<AuthBloc, AuthState>(
            builder: (ctx, state) {
              if (state is! AuthAuthenticated) return const EvInlineLoader();
              final user = state.user;
              return ListView(
                padding: AppSpacing.screenPadding,
                children: [
                  // Avatar + name
                  Center(
                    child: Column(children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundColor: context.colors.primary.withOpacity(0.15),
                        child: Text(
                          (user.name?.isNotEmpty == true ? user.name![0] : user.phone[0]).toUpperCase(),
                          style: AppTypography.h1.copyWith(color: context.colors.primary),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(user.name ?? 'Rider', style: AppTypography.h3.copyWith(color: context.colors.textPrimary)),
                      Text('+91 ${user.phone}', style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary)),
                    ]),
                  ),
                  const SizedBox(height: AppSpacing.x3l),

                  // Menu items
                  _MenuItem(icon: Icons.edit_rounded, label: 'Edit Profile', onTap: () {}),
                  _MenuItem(icon: Icons.language_rounded, label: 'Language', onTap: () {}),
                  _MenuItem(icon: Icons.help_outline_rounded, label: 'Help & Support', onTap: () {}),
                  _MenuItem(icon: Icons.privacy_tip_outlined, label: 'Privacy Policy', onTap: () {}),
                  _MenuItem(icon: Icons.description_outlined, label: 'Terms of Service', onTap: () {}),
                  const SizedBox(height: AppSpacing.lg),
                  Divider(color: context.colors.divider),
                  const SizedBox(height: AppSpacing.sm),
                  _MenuItem(
                    icon: Icons.logout_rounded,
                    label: 'Log Out',
                    color: context.colors.error,
                    onTap: () async {
                      final confirmed = await EvDialog.show(
                        ctx,
                        title: 'Log Out',
                        message: 'Are you sure you want to log out?',
                        confirmLabel: 'Log Out',
                      );
                      if (confirmed == true && ctx.mounted) {
                        ctx.read<AuthBloc>().add(LogoutRequested());
                      }
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;
  const _MenuItem({required this.icon, required this.label, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? context.colors.textPrimary;
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      leading: Icon(icon, color: c),
      title: Text(label, style: AppTypography.bodyLarge.copyWith(color: c)),
      trailing: color == null ? Icon(Icons.chevron_right_rounded, color: context.colors.textDisabled) : null,
      onTap: onTap,
    );
  }
}
