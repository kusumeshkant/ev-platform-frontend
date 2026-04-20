import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brand_config/brand_config.dart';
import 'package:design_system/design_system.dart';

import 'core/di/injection.dart';
import 'core/router/admin_router.dart';
import 'core/bloc/admin_theme_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BrandConfig.load();
  configureDependencies();
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdminThemeCubit(BrandConfig.current),
      child: BlocBuilder<AdminThemeCubit, AdminThemeState>(
        builder: (_, state) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: '${BrandConfig.current.appName} Admin',
          routerConfig: AdminRouter.config,
          theme:      state.lightTheme,
          darkTheme:  state.darkTheme,
          themeMode:  state.mode,
        ),
      ),
    );
  }
}
