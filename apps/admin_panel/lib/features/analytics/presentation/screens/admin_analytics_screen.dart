import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:localization/localization.dart';

class AdminAnalyticsScreen extends StatelessWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),
          Text('Analytics', style: AppTypography.h2.copyWith(color: context.colors.textPrimary)),
          const SizedBox(height: AppSpacing.x3l),

          // Revenue chart placeholder
          EvCard(
            shadow: AppShadows.md,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Monthly Revenue', style: AppTypography.h4.copyWith(color: context.colors.textPrimary)),
                const SizedBox(height: AppSpacing.xxl),
                SizedBox(
                  height: 200,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(7, (i) {
                      const months = ['Oct', 'Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr'];
                      const heights = [0.4, 0.55, 0.7, 0.6, 0.8, 0.65, 0.9];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: 32,
                            height: 180 * heights[i],
                            decoration: BoxDecoration(
                              color: i == 6
                                  ? context.colors.primary
                                  : context.colors.primary.withOpacity(0.3),
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(AppRadius.xs)),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Text(months[i], style: AppTypography.caption.copyWith(color: context.colors.textSecondary)),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Stats row
          Row(children: [
            Expanded(child: _StatCard('Avg Ride Duration', '14 min', Icons.timer_rounded)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: _StatCard('Avg Fare', '₹28.40', Icons.currency_rupee_rounded)),
            if (context.isWide) ...[
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _StatCard('Rides Today', '142', Icons.route_rounded)),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: _StatCard('New Users Today', '23', Icons.person_add_rounded)),
            ],
          ]),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label, value;
  final IconData icon;
  const _StatCard(this.label, this.value, this.icon);

  @override
  Widget build(BuildContext context) {
    return EvCard(
      shadow: AppShadows.md,
      child: Row(children: [
        Icon(icon, color: context.colors.primary, size: 28),
        const SizedBox(width: AppSpacing.md),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(value, style: AppTypography.h3.copyWith(color: context.colors.textPrimary)),
          Text(label, style: AppTypography.caption.copyWith(color: context.colors.textSecondary)),
        ]),
      ]),
    );
  }
}
