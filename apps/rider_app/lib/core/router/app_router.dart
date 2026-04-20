import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:core_flutter/core_flutter.dart';

import '../../features/auth/presentation/screens/phone_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/vehicles/presentation/screens/vehicle_detail_screen.dart';
import '../../features/ride/presentation/screens/active_ride_screen.dart';
import '../../features/ride/presentation/screens/ride_complete_screen.dart';
import '../../features/ride/presentation/screens/ride_history_screen.dart';
import '../../features/wallet/presentation/screens/wallet_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../shell/app_shell.dart';
import 'route_names.dart';

abstract final class AppRouter {
  static final _key = GlobalKey<NavigatorState>();

  static final GoRouter config = GoRouter(
    navigatorKey: _key,
    initialLocation: RouteNames.home,
    redirect: _guard,
    routes: [
      // Auth flow (outside shell)
      GoRoute(path: RouteNames.phone, builder: (_, __) => const PhoneScreen()),
      GoRoute(
        path: RouteNames.otp,
        builder: (_, state) => OtpScreen(phone: state.extra as String),
      ),

      // Main shell (bottom nav)
      ShellRoute(
        builder: (_, __, child) => AppShell(child: child),
        routes: [
          GoRoute(path: RouteNames.home,    builder: (_, __) => const HomeScreen()),
          GoRoute(path: RouteNames.rides,   builder: (_, __) => const RideHistoryScreen()),
          GoRoute(path: RouteNames.wallet,  builder: (_, __) => const WalletScreen()),
          GoRoute(path: RouteNames.profile, builder: (_, __) => const ProfileScreen()),
        ],
      ),

      // Outside shell (full-screen flows)
      GoRoute(
        path: RouteNames.vehicleDetail,
        builder: (_, state) => VehicleDetailScreen(vehicleId: state.pathParameters['id']!),
      ),
      GoRoute(path: RouteNames.activeRide,    builder: (_, __) => const ActiveRideScreen()),
      GoRoute(
        path: RouteNames.rideComplete,
        builder: (_, state) => RideCompleteScreen(rideId: state.extra as String),
      ),
    ],
  );

  static String? _guard(BuildContext context, GoRouterState state) {
    final isAuthed = getIt<TokenStorage>().hasToken;
    final isAuthRoute = state.matchedLocation.startsWith('/auth');
    // Redirect to phone screen if not authenticated and not already on auth route
    // (hasToken is a Future — use AuthBloc in practice for sync check)
    return null; // Handled by AuthBloc listener in AppShell
  }
}
