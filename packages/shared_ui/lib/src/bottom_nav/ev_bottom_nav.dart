import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';
import 'package:assets_registry/assets_registry.dart';

class EvBottomNav extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const EvBottomNav({super.key, required this.currentIndex, required this.onTap});

  static const _items = [
    _Item(icon: AppIcons.home,          label: 'Home'),
    _Item(icon: AppIcons.history,       label: 'Rides'),
    _Item(icon: AppIcons.wallet,        label: 'Wallet'),
    _Item(icon: AppIcons.profile,       label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: context.colors.surface, boxShadow: AppShadows.floating),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppSpacing.bottomNavHeight,
          child: Row(
            children: List.generate(_items.length, (i) => Expanded(
              child: _NavItem(item: _items[i], selected: currentIndex == i, onTap: () => onTap(i)),
            )),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final _Item item;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({required this.item, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        AppSvg(item.icon, size: 24,
          color: selected ? context.colors.primary : context.colors.textSecondary,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(item.label, style: AppTypography.labelSmall.copyWith(
          color: selected ? context.colors.primary : context.colors.textSecondary,
          fontWeight: selected ? AppFontWeights.semiBold : AppFontWeights.regular,
        )),
      ]),
    );
  }
}

class _Item {
  final String icon;
  final String label;
  const _Item({required this.icon, required this.label});
}
