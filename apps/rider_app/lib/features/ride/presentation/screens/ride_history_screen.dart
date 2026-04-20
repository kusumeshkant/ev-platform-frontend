import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:localization/localization.dart';

import '../bloc/ride_history_bloc.dart';
import '../../domain/entities/ride.dart';
import '../../../../../core/di/injection.dart';

class RideHistoryScreen extends StatelessWidget {
  const RideHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RideHistoryBloc(getIt())..add(LoadRideHistory()),
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: EvAppBar(title: 'My Rides', showBack: false),
        body: BlocBuilder<RideHistoryBloc, RideHistoryState>(
          builder: (_, state) => switch (state) {
            RideHistoryLoading() => ListView.separated(
                padding: AppSpacing.screenPadding,
                itemCount: 5,
                separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                itemBuilder: (_, __) => EvShimmer(
                  child: Container(height: 80, decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: AppRadius.cardRadius,
                  )),
                ),
              ),
            RideHistoryLoaded(:final rides) when rides.isEmpty => const EvEmptyState(
                icon: Icons.electric_scooter_rounded,
                title: 'No rides yet',
                subtitle: 'Your completed rides will appear here',
              ),
            RideHistoryLoaded(:final rides) => ListView.separated(
                padding: AppSpacing.screenPadding,
                itemCount: rides.length,
                separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                itemBuilder: (_, i) => _RideTile(ride: rides[i]),
              ),
            RideHistoryError(:final message) => EvErrorState(message: message),
            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}

class _RideTile extends StatelessWidget {
  final Ride ride;
  const _RideTile({required this.ride});

  @override
  Widget build(BuildContext context) {
    return EvCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(color: context.colors.successSurface, shape: BoxShape.circle),
            child: Icon(Icons.electric_scooter_rounded, color: context.colors.success, size: 24),
          ),
          const SizedBox(width: AppSpacing.lg),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(DateFormatter.ride(ride.startTime),
                  style: AppTypography.labelLarge.copyWith(color: context.colors.textPrimary)),
                const SizedBox(height: AppSpacing.xs),
                Text('${ride.distanceKm?.toStringAsFixed(1) ?? '—'} km · ${ride.duration.inMinutes} min',
                  style: AppTypography.bodySmall.copyWith(color: context.colors.textSecondary)),
              ],
            ),
          ),
          Text(ride.totalFare != null ? '₹${ride.totalFare!.toStringAsFixed(2)}' : '—',
            style: AppTypography.labelLarge.copyWith(color: context.colors.textPrimary)),
        ],
      ),
    );
  }
}
