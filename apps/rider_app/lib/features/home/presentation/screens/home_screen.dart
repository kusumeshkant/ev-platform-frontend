import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:assets_registry/assets_registry.dart';

import '../../../vehicles/presentation/bloc/nearby_vehicles_bloc.dart';
import '../../../vehicles/domain/entities/vehicle.dart';
import '../../../ride/presentation/bloc/ride_bloc.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/router/route_names.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => NearbyVehiclesBloc(getIt())..add(LoadNearbyVehicles(12.9716, 77.5946))),
        BlocProvider(create: (_) => RideBloc(getIt())..add(LoadActiveRide())),
      ],
      child: BlocListener<RideBloc, RideState>(
        listener: (ctx, state) {
          if (state is RideActive) ctx.go(RouteNames.activeRide);
        },
        child: AdaptiveLayout(
          phone: const _HomePhone(),
          tabletS: const _HomeTablet(),
        ),
      ),
    );
  }
}

// ── Phone layout ─────────────────────────────────────────────────────────────
class _HomePhone extends StatelessWidget {
  const _HomePhone();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Map background
          GoogleMap(
            initialCameraPosition: const CameraPosition(target: LatLng(12.9716, 77.5946), zoom: 14),
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),

          // Top search bar
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  decoration: BoxDecoration(
                    color: context.colors.surface,
                    borderRadius: BorderRadius.circular(AppRadius.full),
                    boxShadow: AppShadows.md,
                  ),
                  child: Row(children: [
                    AppSvg(AppIcons.location, size: 20, color: context.colors.primary),
                    const SizedBox(width: AppSpacing.sm),
                    Text('Search locations, scooters...', style: AppTypography.bodyMedium.copyWith(color: context.colors.textHint)),
                    const Spacer(),
                    AppSvg(AppIcons.notifications, size: 20, color: context.colors.textSecondary),
                  ]),
                ),
              ),
            ),
          ),

          // Bottom sheet
          DraggableScrollableSheet(
            initialChildSize: 0.28,
            minChildSize: 0.1,
            maxChildSize: 0.85,
            builder: (_, controller) => Container(
              decoration: BoxDecoration(
                color: context.colors.surface,
                borderRadius: AppRadius.bottomSheetRadius,
                boxShadow: AppShadows.floating,
              ),
              child: Column(children: [
                const SizedBox(height: AppSpacing.sm),
                Container(width: 40, height: 4, decoration: BoxDecoration(color: context.colors.border, borderRadius: BorderRadius.circular(AppRadius.full))),
                const SizedBox(height: AppSpacing.lg),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Row(children: [
                    Text('Nearby Vehicles', style: AppTypography.h4.copyWith(color: context.colors.textPrimary)),
                    const Spacer(),
                    BlocBuilder<NearbyVehiclesBloc, NearbyVehiclesState>(
                      builder: (_, state) => state is NearbyVehiclesLoaded
                          ? Text('${state.vehicles.length} found', style: AppTypography.labelMedium.copyWith(color: context.colors.textSecondary))
                          : const SizedBox.shrink(),
                    ),
                  ]),
                ),
                const SizedBox(height: AppSpacing.sm),
                Expanded(child: _VehicleList(controller: controller)),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Tablet layout ─────────────────────────────────────────────────────────────
class _HomeTablet extends StatelessWidget {
  const _HomeTablet();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(children: [
        SizedBox(
          width: 360,
          child: Column(children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: AppSpacing.screenPadding,
                child: Text('Nearby Vehicles', style: AppTypography.h3.copyWith(color: context.colors.textPrimary)),
              ),
            ),
            Expanded(child: _VehicleList()),
          ]),
        ),
        const VerticalDivider(width: 1),
        const Expanded(child: GoogleMap(
          initialCameraPosition: CameraPosition(target: LatLng(12.9716, 77.5946), zoom: 14),
          myLocationEnabled: true,
        )),
      ]),
    );
  }
}

// ── Shared vehicle list ───────────────────────────────────────────────────────
class _VehicleList extends StatelessWidget {
  final ScrollController? controller;
  const _VehicleList({this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NearbyVehiclesBloc, NearbyVehiclesState>(
      builder: (ctx, state) => switch (state) {
        NearbyVehiclesLoading() => ListView.separated(
            controller: controller,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            itemCount: 5,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, __) => EvShimmer(
              child: Container(height: 88, decoration: BoxDecoration(color: Colors.white, borderRadius: AppRadius.cardRadius)),
            ),
          ),
        NearbyVehiclesLoaded(:final vehicles) when vehicles.isEmpty => const EvEmptyState(
            icon: Icons.electric_scooter_rounded,
            title: 'No vehicles nearby',
            subtitle: 'Try moving to a different location',
          ),
        NearbyVehiclesLoaded(:final vehicles) => ListView.separated(
            controller: controller,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            itemCount: vehicles.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, i) => _VehicleCard(
              vehicle: vehicles[i],
              onTap: () => ctx.push('/vehicle/${vehicles[i].id}'),
            ),
          ),
        NearbyVehiclesError(:final message) => EvErrorState(message: message),
        _ => const SizedBox.shrink(),
      },
    );
  }
}

class _VehicleCard extends StatelessWidget {
  final Vehicle vehicle;
  final VoidCallback onTap;
  const _VehicleCard({required this.vehicle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return EvCard(
      onTap: onTap,
      child: Row(children: [
        Container(
          width: 64, height: 64,
          decoration: BoxDecoration(color: context.colors.surfaceVariant, borderRadius: BorderRadius.circular(AppRadius.sm)),
          child: Icon(Icons.electric_scooter_rounded, size: 32, color: context.colors.textDisabled),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(vehicle.model, style: AppTypography.h4.copyWith(color: context.colors.textPrimary)),
            const SizedBox(height: AppSpacing.xs),
            Row(children: [
              AppSvg(AppIcons.batteryIcon(vehicle.batteryLevel), size: 14, color: _batteryColor(context)),
              const SizedBox(width: 4),
              Text('${vehicle.batteryLevel}%', style: AppTypography.labelSmall.copyWith(color: _batteryColor(context))),
              const SizedBox(width: AppSpacing.md),
              Text('${vehicle.distanceKm.toStringAsFixed(1)} km', style: AppTypography.bodySmall.copyWith(color: context.colors.textSecondary)),
            ]),
            const SizedBox(height: AppSpacing.xs),
            Text('₹${vehicle.ratePerMinute}/min', style: AppTypography.labelMedium.copyWith(color: context.colors.primary)),
          ]),
        ),
        _StatusDot(status: vehicle.status),
      ]),
    );
  }

  Color _batteryColor(BuildContext ctx) {
    if (vehicle.batteryLevel > 60) return ctx.colors.batteryHigh;
    if (vehicle.batteryLevel > 20) return ctx.colors.batteryMid;
    return ctx.colors.batteryLow;
  }
}

class _StatusDot extends StatelessWidget {
  final VehicleStatus status;
  const _StatusDot({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = switch (status) {
      VehicleStatus.available  => context.colors.scooterAvailable,
      VehicleStatus.inRide     => context.colors.scooterInRide,
      VehicleStatus.lowBattery => context.colors.batteryLow,
      VehicleStatus.offline    => context.colors.scooterOffline,
    };
    return Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle));
  }
}
