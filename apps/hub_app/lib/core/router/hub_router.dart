import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_ui/shared_ui.dart';
import '../../features/fleet/presentation/screens/fleet_screen.dart';
import '../../features/qr_scan/presentation/screens/qr_scan_screen.dart';
import '../../features/dashboard/presentation/screens/hub_dashboard_screen.dart';

abstract final class HubRouter {
  static final GoRouter config = GoRouter(
    initialLocation: '/dashboard',
    routes: [
      ShellRoute(
        builder: (_, __, child) => _HubShell(child: child),
        routes: [
          GoRoute(path: '/dashboard', builder: (_, __) => const HubDashboardScreen()),
          GoRoute(path: '/fleet',     builder: (_, __) => const FleetScreen()),
          GoRoute(path: '/scan',      builder: (_, __) => const QrScanScreen()),
        ],
      ),
    ],
  );
}

class _HubShell extends StatelessWidget {
  final Widget child;
  const _HubShell({required this.child});

  @override
  Widget build(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    final idx = loc.startsWith('/fleet') ? 1 : loc.startsWith('/scan') ? 2 : 0;

    if (context.isTablet) {
      return Scaffold(
        body: Row(children: [
          NavigationRail(
            selectedIndex: idx,
            onDestinationSelected: (i) => context.go(['/dashboard', '/fleet', '/scan'][i]),
            destinations: const [
              NavigationRailDestination(icon: Icon(Icons.dashboard_rounded), label: Text('Dashboard')),
              NavigationRailDestination(icon: Icon(Icons.electric_scooter_rounded), label: Text('Fleet')),
              NavigationRailDestination(icon: Icon(Icons.qr_code_scanner_rounded), label: Text('Scan')),
            ],
          ),
          const VerticalDivider(width: 1),
          Expanded(child: child),
        ]),
      );
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: (i) => context.go(['/dashboard', '/fleet', '/scan'][i]),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard_rounded), label: 'Dashboard'),
          NavigationDestination(icon: Icon(Icons.electric_scooter_rounded), label: 'Fleet'),
          NavigationDestination(icon: Icon(Icons.qr_code_scanner_rounded), label: 'Scan'),
        ],
      ),
    );
  }
}
