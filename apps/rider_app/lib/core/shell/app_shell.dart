import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_ui/shared_ui.dart';

import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../di/injection.dart';
import '../router/route_names.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  static const _tabs = [
    RouteNames.home,
    RouteNames.rides,
    RouteNames.wallet,
    RouteNames.profile,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>()..add(CheckAuthStatus()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthUnauthenticated) {
            context.go(RouteNames.phone);
          }
        },
        child: _ShellScaffold(child: child),
      ),
    );
  }
}

class _ShellScaffold extends StatelessWidget {
  final Widget child;
  const _ShellScaffold({required this.child});

  int _indexFor(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    return switch (loc) {
      _ when loc.startsWith(RouteNames.rides)   => 1,
      _ when loc.startsWith(RouteNames.wallet)  => 2,
      _ when loc.startsWith(RouteNames.profile) => 3,
      _                                         => 0,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: EvBottomNav(
        currentIndex: _indexFor(context),
        onTap: (i) => context.go(AppShell._tabs[i]),
      ),
    );
  }
}
