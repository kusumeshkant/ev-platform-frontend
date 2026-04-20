import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:brand_config/brand_config.dart';

import '../bloc/admin_theme_cubit.dart';

class AdminShell extends StatelessWidget {
  final Widget child;
  const AdminShell({super.key, required this.child});

  static const _navItems = [
    _NavItem('/dashboard', Icons.dashboard_rounded,          'Dashboard'),
    _NavItem('/vehicles',  Icons.electric_scooter_rounded,   'Vehicles'),
    _NavItem('/rides',     Icons.route_rounded,              'Rides'),
    _NavItem('/users',     Icons.people_rounded,             'Users'),
    _NavItem('/hubs',      Icons.location_on_rounded,        'Hubs'),
    _NavItem('/analytics', Icons.analytics_rounded,          'Analytics'),
  ];

  int _selectedIndex(BuildContext context) {
    final loc = GoRouterState.of(context).matchedLocation;
    return _navItems.indexWhere((n) => loc.startsWith(n.path)).clamp(0, _navItems.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    final idx = _selectedIndex(context);

    return Scaffold(
      backgroundColor: context.colors.background,
      body: Column(children: [
        // Top bar
        Container(
          height: 64,
          color: context.colors.surface,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.x3l),
          child: Row(children: [
            Text(
              BrandConfig.current.appName,
              style: AppTypography.h3.copyWith(color: context.colors.primary),
            ),
            const SizedBox(width: AppSpacing.xs),
            Text('Admin', style: AppTypography.h4.copyWith(color: context.colors.textSecondary)),
            const Spacer(),
            IconButton(
              icon: Icon(Icons.light_mode_rounded, color: context.colors.textSecondary),
              onPressed: () => context.read<AdminThemeCubit>().toggle(),
            ),
            const SizedBox(width: AppSpacing.sm),
            CircleAvatar(
              radius: 18,
              backgroundColor: context.colors.primary,
              child: Text('A', style: AppTypography.labelLarge.copyWith(color: Colors.white)),
            ),
          ]),
        ),
        Divider(height: 1, color: context.colors.divider),

        // Body row: sidebar + content
        Expanded(
          child: Row(children: [
            // Side navigation
            AnimatedContainer(
              duration: AppMotion.normal,
              width: responsiveValue(context, phone: 0, tabletS: 64, tabletL: 240, desktop: 280),
              color: context.colors.surface,
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  ..._navItems.asMap().entries.map((e) {
                    final selected = idx == e.key;
                    final wide = context.screenWidth >= Breakpoints.tabletL;
                    return Tooltip(
                      message: wide ? '' : e.value.label,
                      child: InkWell(
                        onTap: () => context.go(e.value.path),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
                          padding: EdgeInsets.symmetric(
                            horizontal: wide ? AppSpacing.lg : AppSpacing.sm,
                            vertical: AppSpacing.md,
                          ),
                          decoration: BoxDecoration(
                            color: selected ? context.colors.primary.withOpacity(0.1) : Colors.transparent,
                            borderRadius: AppRadius.buttonRadius,
                          ),
                          child: Row(children: [
                            Icon(e.value.icon,
                              color: selected ? context.colors.primary : context.colors.textSecondary,
                              size: 22,
                            ),
                            if (wide) ...[
                              const SizedBox(width: AppSpacing.md),
                              Text(e.value.label,
                                style: AppTypography.labelLarge.copyWith(
                                  color: selected ? context.colors.primary : context.colors.textSecondary,
                                  fontWeight: selected ? AppFontWeights.semiBold : AppFontWeights.regular,
                                ),
                              ),
                            ],
                          ]),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            if (context.screenWidth >= Breakpoints.tabletS)
              VerticalDivider(width: 1, color: context.colors.divider),

            // Main content
            Expanded(child: child),
          ]),
        ),
      ]),
    );
  }
}

class _NavItem {
  final String path, label;
  final IconData icon;
  const _NavItem(this.path, this.icon, this.label);
}
