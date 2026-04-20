import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';

class AdminVehiclesScreen extends StatelessWidget {
  const AdminVehiclesScreen({super.key});

  static final _vehicles = List.generate(20, (i) => (
    id: 'EV-${1000 + i}', model: i % 3 == 0 ? 'Ather 450X' : i % 3 == 1 ? 'Ola S1 Pro' : 'TVS iQube',
    battery: 20 + (i * 7) % 80,
    status: i % 5 == 0 ? 'in_ride' : i % 7 == 0 ? 'offline' : 'available',
    hub: 'Hub ${(i % 4) + 1}',
  ));

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: AppSpacing.screenPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.lg),
          Row(children: [
            Expanded(child: Text('Vehicles', style: AppTypography.h2.copyWith(color: context.colors.textPrimary))),
            EvButton(label: 'Add Vehicle', onPressed: () {}, isFullWidth: false, size: EvButtonSize.medium),
          ]),
          const SizedBox(height: AppSpacing.x3l),
          EvCard(
            shadow: AppShadows.md,
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                // Header
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: context.colors.divider))),
                  child: Row(children: [
                    _Head('Vehicle ID', flex: 2),
                    _Head('Model',      flex: 2),
                    _Head('Battery',    flex: 1),
                    _Head('Status',     flex: 2),
                    _Head('Hub',        flex: 2),
                    _Head('Actions',    flex: 1),
                  ]),
                ),
                // Rows
                ..._vehicles.map((v) => Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                  decoration: BoxDecoration(border: Border(bottom: BorderSide(color: context.colors.divider, width: 0.5))),
                  child: Row(children: [
                    _Cell(v.id,    flex: 2, bold: true),
                    _Cell(v.model, flex: 2),
                    Expanded(flex: 1, child: _BatteryCell(level: v.battery)),
                    Expanded(flex: 2, child: _StatusChip(status: v.status)),
                    _Cell(v.hub, flex: 2),
                    Expanded(flex: 1, child: IconButton(
                      icon: Icon(Icons.more_vert_rounded, color: context.colors.textSecondary),
                      onPressed: () {},
                    )),
                  ]),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Head extends StatelessWidget {
  final String text; final int flex;
  const _Head(this.text, {required this.flex});
  @override
  Widget build(BuildContext ctx) => Expanded(flex: flex,
    child: Text(text, style: AppTypography.labelSmall.copyWith(color: ctx.colors.textSecondary)));
}

class _Cell extends StatelessWidget {
  final String text; final int flex; final bool bold;
  const _Cell(this.text, {required this.flex, this.bold = false});
  @override
  Widget build(BuildContext ctx) => Expanded(flex: flex,
    child: Text(text, style: (bold ? AppTypography.labelLarge : AppTypography.bodySmall).copyWith(color: ctx.colors.textPrimary)));
}

class _BatteryCell extends StatelessWidget {
  final int level;
  const _BatteryCell({required this.level});
  @override
  Widget build(BuildContext ctx) {
    final color = level > 60 ? ctx.colors.batteryHigh : level > 20 ? ctx.colors.batteryMid : ctx.colors.batteryLow;
    return Text('$level%', style: AppTypography.labelMedium.copyWith(color: color));
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});
  @override
  Widget build(BuildContext ctx) {
    final (label, color) = switch (status) {
      'available' => ('Available', ctx.colors.scooterAvailable),
      'in_ride'   => ('In Ride',   ctx.colors.scooterInRide),
      _           => ('Offline',   ctx.colors.scooterOffline),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(color: color.withOpacity(0.12), borderRadius: AppRadius.chipRadius),
      child: Text(label, style: AppTypography.labelSmall.copyWith(color: color)),
    );
  }
}
