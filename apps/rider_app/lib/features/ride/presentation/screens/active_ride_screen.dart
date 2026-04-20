import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:localization/localization.dart';

import '../bloc/ride_bloc.dart';
import '../../domain/entities/ride.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/router/route_names.dart';

class ActiveRideScreen extends StatelessWidget {
  const ActiveRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RideBloc(getIt())..add(LoadActiveRide()),
      child: BlocListener<RideBloc, RideState>(
        listener: (ctx, state) {
          if (state is RideCompleted) {
            ctx.go(RouteNames.rideComplete, extra: state.ride.id);
          }
          if (state is RideError) {
            EvSnackBar.show(ctx, state.message, type: EvSnackBarType.error);
          }
        },
        child: const _ActiveRideView(),
      ),
    );
  }
}

class _ActiveRideView extends StatefulWidget {
  const _ActiveRideView();
  @override
  State<_ActiveRideView> createState() => _ActiveRideViewState();
}

class _ActiveRideViewState extends State<_ActiveRideView> {
  Timer? _timer;
  int _elapsed = 0;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _elapsed++);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      body: SafeArea(
        child: BlocBuilder<RideBloc, RideState>(
          builder: (ctx, state) {
            if (state is RideLoading) return const EvInlineLoader();
            if (state is! RideActive) return const SizedBox.shrink();
            final ride = state.ride;

            return Column(
              children: [
                // Header
                Container(
                  color: context.colors.primary,
                  padding: AppSpacing.screenPadding,
                  child: Row(
                    children: [
                      const Icon(Icons.electric_scooter_rounded, color: Colors.white, size: 28),
                      const SizedBox(width: AppSpacing.sm),
                      Text('Active Ride', style: AppTypography.h3.copyWith(color: Colors.white)),
                    ],
                  ),
                ),

                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Duration', style: AppTypography.labelLarge.copyWith(color: context.colors.textSecondary)),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        DateFormatter.duration(ride.duration.inSeconds + _elapsed),
                        style: AppTypography.timerDisplay.copyWith(color: context.colors.textPrimary),
                      ),
                      const SizedBox(height: AppSpacing.x4l),
                      Text('Estimated fare', style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary)),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        '₹${((ride.duration.inSeconds + _elapsed) / 60 * 2).toStringAsFixed(2)}',
                        style: AppTypography.fareDisplay.copyWith(color: context.colors.primary),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: AppSpacing.screenPadding,
                  child: BlocBuilder<RideBloc, RideState>(
                    builder: (ctx, state) => EvButton(
                      label: 'End Ride',
                      isLoading: state is RideLoading,
                      onPressed: () async {
                        final confirmed = await EvDialog.show(
                          ctx,
                          title: 'End this ride?',
                          message: 'You will be charged for the total duration.',
                          confirmLabel: 'End Ride',
                          isDestructive: false,
                        );
                        if (confirmed == true && ctx.mounted) {
                          ctx.read<RideBloc>().add(EndRide(ride.id));
                        }
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
