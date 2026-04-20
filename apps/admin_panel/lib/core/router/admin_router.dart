import 'package:go_router/go_router.dart';
import '../shell/admin_shell.dart';
import '../../features/dashboard/presentation/screens/admin_dashboard_screen.dart';
import '../../features/vehicles/presentation/screens/admin_vehicles_screen.dart';
import '../../features/rides/presentation/screens/admin_rides_screen.dart';
import '../../features/users/presentation/screens/admin_users_screen.dart';
import '../../features/hubs/presentation/screens/admin_hubs_screen.dart';
import '../../features/analytics/presentation/screens/admin_analytics_screen.dart';

abstract final class AdminRouter {
  static final GoRouter config = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        builder: (_, __, child) => AdminShell(child: child),
        routes: [
          GoRoute(path: '/dashboard', builder: (_, __) => const AdminDashboardScreen()),
          GoRoute(path: '/vehicles',  builder: (_, __) => const AdminVehiclesScreen()),
          GoRoute(path: '/rides',     builder: (_, __) => const AdminRidesScreen()),
          GoRoute(path: '/users',     builder: (_, __) => const AdminUsersScreen()),
          GoRoute(path: '/hubs',      builder: (_, __) => const AdminHubsScreen()),
          GoRoute(path: '/analytics', builder: (_, __) => const AdminAnalyticsScreen()),
        ],
      ),
    ],
  );
}
