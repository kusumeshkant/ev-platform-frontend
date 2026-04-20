import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:assets_registry/assets_registry.dart';

import '../bloc/vehicle_detail_bloc.dart';
import '../../domain/entities/vehicle.dart';
import '../../../ride/presentation/bloc/ride_bloc.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/router/route_names.dart';

class VehicleDetailScreen extends StatelessWidget {
  final String vehicleId;
  const VehicleDetailScreen({super.key, required this.vehicleId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => VehicleDetailBloc(getIt())..add(LoadVehicleDetail(vehicleId))),
        BlocProvider(create: (_) => RideBloc(getIt())),
      ],
      child: BlocListener<RideBloc, RideState>(
        listener: (ctx, state) {
          if (state is RideStarted) ctx.go(RouteNames.activeRide);
          if (state is RideError) EvSnackBar.show(ctx, state.message, type: EvSnackBarType.error);
        },
        child: Scaffold(
          backgroundColor: context.colors.background,
          appBar: EvAppBar(title: 'Vehicle Details'),
          body: BlocBuilder<VehicleDetailBloc, VehicleDetailState>(
            builder: (ctx, state) => switch (state) {
              VehicleDetailLoading() => const EvInlineLoader(),
              VehicleDetailLoaded(:final vehicle) => _VehicleBody(vehicle: vehicle),
              VehicleDetailError(:final message) => EvErrorState(message: message),
              _ => const SizedBox.shrink(),
            },
          ),
        ),
      ),
    );
  }
}

class _VehicleBody extends StatelessWidget {
  final Vehicle vehicle;
  const _VehicleBody({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: AppSpacing.screenPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Vehicle image placeholder
                Container(
                  height: 200,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: context.colors.surfaceVariant,
                    borderRadius: AppRadius.cardRadius,
                  ),
                  child: Icon(Icons.electric_scooter_rounded, size: 80, color: context.colors.textDisabled),
                ),
                const SizedBox(height: AppSpacing.xxl),

                // Model name + status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(vehicle.model, style: AppTypography.h2.copyWith(color: context.colors.textPrimary)),
                    _StatusChip(status: vehicle.status),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Battery + distance row
                Row(children: [
                  AppSvg(AppIcons.batteryIcon(vehicle.batteryLevel), size: 20, color: _batteryColor(context)),
                  const SizedBox(width: AppSpacing.xs),
                  Text('${vehicle.batteryLevel}%', style: AppTypography.labelLarge.copyWith(color: _batteryColor(context))),
                  const SizedBox(width: AppSpacing.xxl),
                  const Icon(Icons.location_on_rounded, size: 18),
                  const SizedBox(width: AppSpacing.xs),
                  Text('${vehicle.distanceKm.toStringAsFixed(1)} km away',
                    style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary)),
                ]),
                const SizedBox(height: AppSpacing.xxl),

                // Rate
                EvCard(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Rate per minute', style: AppTypography.bodyMedium.copyWith(color: context.colors.textSecondary)),
                      Text('₹${vehicle.ratePerMinute}/min', style: AppTypography.h4.copyWith(color: context.colors.primary)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: AppSpacing.screenPadding,
          child: BlocBuilder<RideBloc, RideState>(
            builder: (ctx, state) => EvButton(
              label: 'Unlock Scooter',
              isLoading: state is RideLoading,
              onPressed: vehicle.isAvailable
                  ? () => ctx.read<RideBloc>().add(StartRide(vehicle.id))
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Color _batteryColor(BuildContext ctx) {
    if (vehicle.batteryLevel > 60) return ctx.colors.batteryHigh;
    if (vehicle.batteryLevel > 20) return ctx.colors.batteryMid;
    return ctx.colors.batteryLow;
  }
}

class _StatusChip extends StatelessWidget {
  final VehicleStatus status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final (label, color) = switch (status) {
      VehicleStatus.available  => ('Available',   context.colors.scooterAvailable),
      VehicleStatus.inRide     => ('In Ride',     context.colors.scooterInRide),
      VehicleStatus.lowBattery => ('Low Battery', context.colors.batteryLow),
      VehicleStatus.offline    => ('Offline',     context.colors.scooterOffline),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: AppRadius.chipRadius,
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(label, style: AppTypography.labelSmall.copyWith(color: color)),
    );
  }
}
