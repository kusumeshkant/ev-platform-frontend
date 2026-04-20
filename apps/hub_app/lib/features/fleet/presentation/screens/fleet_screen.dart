import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import '../../domain/repositories/fleet_repository.dart';

class FleetScreen extends StatelessWidget {
  const FleetScreen({super.key});

  // Placeholder data until connected to real BLoC
  static final _vehicles = List.generate(12, (i) => FleetVehicle(
    id: 'EV-${1000 + i}', model: 'Ather 450X',
    status: i % 5 == 0 ? 'in_ride' : i % 7 == 0 ? 'offline' : 'available',
    batteryLevel: 20 + (i * 7) % 80,
  ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.background,
      appBar: EvAppBar(title: 'Fleet', showBack: false, actions: [
        IconButton(icon: Icon(Icons.filter_list_rounded, color: context.colors.textPrimary), onPressed: () {}),
      ]),
      body: ListView.separated(
        padding: AppSpacing.screenPadding,
        itemCount: _vehicles.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (_, i) => _FleetTile(vehicle: _vehicles[i]),
      ),
    );
  }
}

class _FleetTile extends StatelessWidget {
  final FleetVehicle vehicle;
  const _FleetTile({required this.vehicle});

  @override
  Widget build(BuildContext context) {
    final (statusColor, statusLabel) = switch (vehicle.status) {
      'available' => (context.colors.scooterAvailable, 'Available'),
      'in_ride'   => (context.colors.scooterInRide,    'In Ride'),
      _           => (context.colors.scooterOffline,   'Offline'),
    };

    return EvCard(
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(color: context.colors.surfaceVariant, borderRadius: BorderRadius.circular(AppRadius.sm)),
          child: Icon(Icons.electric_scooter_rounded, color: context.colors.textSecondary, size: 28),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(vehicle.id, style: AppTypography.h4.copyWith(color: context.colors.textPrimary)),
            Text(vehicle.model, style: AppTypography.bodySmall.copyWith(color: context.colors.textSecondary)),
            const SizedBox(height: AppSpacing.xs),
            Row(children: [
              Icon(Icons.battery_std_rounded, size: 14, color: _batteryColor(context)),
              const SizedBox(width: 2),
              Text('${vehicle.batteryLevel}%', style: AppTypography.labelSmall.copyWith(color: _batteryColor(context))),
            ]),
          ]),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
          decoration: BoxDecoration(color: statusColor.withOpacity(0.12), borderRadius: AppRadius.chipRadius),
          child: Text(statusLabel, style: AppTypography.labelSmall.copyWith(color: statusColor)),
        ),
      ]),
    );
  }

  Color _batteryColor(BuildContext ctx) {
    if (vehicle.batteryLevel > 60) return ctx.colors.batteryHigh;
    if (vehicle.batteryLevel > 20) return ctx.colors.batteryMid;
    return ctx.colors.batteryLow;
  }
}
