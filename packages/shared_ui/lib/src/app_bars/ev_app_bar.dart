import 'package:flutter/material.dart';
import 'package:design_system/design_system.dart';

class EvAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBack;
  final VoidCallback? onBack;
  final PreferredSizeWidget? bottom;
  final bool transparent;

  const EvAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBack = true,
    this.onBack,
    this.bottom,
    this.transparent = false,
  });

  @override
  Size get preferredSize => Size.fromHeight(
    AppSpacing.appBarHeight + (bottom?.preferredSize.height ?? 0),
  );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: transparent ? Colors.transparent : context.colors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: transparent ? 0 : 0,
      scrolledUnderElevation: transparent ? 0 : 1,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
              onPressed: onBack ?? () => Navigator.of(context).maybePop(),
              color: transparent ? Colors.white : context.colors.textPrimary,
            )
          : null,
      automaticallyImplyLeading: showBack,
      title: Text(
        title,
        style: AppTypography.h4.copyWith(
          color: transparent ? Colors.white : context.colors.textPrimary,
        ),
      ),
      actions: actions,
      centerTitle: false,
      bottom: bottom,
    );
  }
}
