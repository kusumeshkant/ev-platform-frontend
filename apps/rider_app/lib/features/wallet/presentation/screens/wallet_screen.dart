import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:design_system/design_system.dart';
import 'package:shared_ui/shared_ui.dart';
import 'package:localization/localization.dart';

import '../bloc/wallet_bloc.dart';
import '../../domain/entities/wallet.dart';
import '../../../../../core/di/injection.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WalletBloc(getIt())..add(LoadWallet()),
      child: Scaffold(
        backgroundColor: context.colors.background,
        appBar: EvAppBar(title: 'My Wallet', showBack: false),
        body: BlocBuilder<WalletBloc, WalletState>(
          builder: (ctx, state) => switch (state) {
            WalletLoading() => const EvInlineLoader(),
            WalletLoaded(:final wallet) => _WalletBody(wallet: wallet),
            WalletError(:final message) => EvErrorState(message: message, onRetry: () => ctx.read<WalletBloc>().add(LoadWallet())),
            _ => const SizedBox.shrink(),
          },
        ),
      ),
    );
  }
}

class _WalletBody extends StatelessWidget {
  final Wallet wallet;
  const _WalletBody({required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Balance card
        Container(
          margin: AppSpacing.screenPadding,
          padding: const EdgeInsets.all(AppSpacing.xxl),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [context.colors.primary, context.colors.primaryDark]),
            borderRadius: AppRadius.cardRadius,
            boxShadow: AppShadows.primaryGlow(context.colors.primary),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Available Balance', style: AppTypography.labelLarge.copyWith(color: Colors.white70)),
              const SizedBox(height: AppSpacing.sm),
              Text(CurrencyFormatter.format(wallet.balance), style: AppTypography.display2.copyWith(color: Colors.white)),
              const SizedBox(height: AppSpacing.xl),
              EvButton(
                label: 'Add Money',
                onPressed: () => _showTopupSheet(context),
                variant: EvButtonVariant.outlined,
              ),
            ],
          ),
        ),

        // Transactions
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Row(children: [
            Text('Transactions', style: AppTypography.h4.copyWith(color: context.colors.textPrimary)),
          ]),
        ),
        const SizedBox(height: AppSpacing.sm),
        Expanded(
          child: wallet.transactions.isEmpty
              ? const EvEmptyState(icon: Icons.receipt_long_rounded, title: 'No transactions yet')
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  itemCount: wallet.transactions.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, i) => _TransactionTile(tx: wallet.transactions[i]),
                ),
        ),
      ],
    );
  }

  void _showTopupSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: context.colors.surface,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.bottomSheetRadius),
      builder: (_) => const _TopupSheet(),
    );
  }
}

class _TransactionTile extends StatelessWidget {
  final WalletTransaction tx;
  const _TransactionTile({required this.tx});

  @override
  Widget build(BuildContext context) {
    return EvCard(
      child: Row(children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: tx.isCredit ? context.colors.successSurface : context.colors.errorSurface,
            shape: BoxShape.circle,
          ),
          child: Icon(tx.isCredit ? Icons.add_rounded : Icons.remove_rounded,
            color: tx.isCredit ? context.colors.success : context.colors.error, size: 20),
        ),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(tx.description, style: AppTypography.labelLarge.copyWith(color: context.colors.textPrimary)),
            Text(DateFormatter.relative(tx.createdAt), style: AppTypography.bodySmall.copyWith(color: context.colors.textSecondary)),
          ]),
        ),
        Text(
          '${tx.isCredit ? '+' : '-'}${CurrencyFormatter.format(tx.amount)}',
          style: AppTypography.labelLarge.copyWith(color: tx.isCredit ? context.colors.success : context.colors.error),
        ),
      ]),
    );
  }
}

class _TopupSheet extends StatefulWidget {
  const _TopupSheet();
  @override
  State<_TopupSheet> createState() => _TopupSheetState();
}

class _TopupSheetState extends State<_TopupSheet> {
  double _selected = 200;
  static const _presets = [100.0, 200.0, 500.0, 1000.0];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg, AppSpacing.xxl, AppSpacing.lg,
        AppSpacing.lg + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Add Money', style: AppTypography.h3.copyWith(color: context.colors.textPrimary)),
          const SizedBox(height: AppSpacing.xl),
          Wrap(
            spacing: AppSpacing.sm,
            children: _presets.map((amt) => ChoiceChip(
              label: Text(CurrencyFormatter.format(amt, decimalDigits: 0)),
              selected: _selected == amt,
              onSelected: (_) => setState(() => _selected = amt),
              selectedColor: context.colors.primary,
              labelStyle: AppTypography.labelMedium.copyWith(
                color: _selected == amt ? context.colors.onPrimary : context.colors.textPrimary,
              ),
            )).toList(),
          ),
          const SizedBox(height: AppSpacing.xl),
          EvButton(
            label: 'Pay ${CurrencyFormatter.format(_selected, decimalDigits: 0)}',
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
