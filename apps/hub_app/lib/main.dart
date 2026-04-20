import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:brand_config/brand_config.dart';
import 'package:localization/localization.dart';
import 'package:design_system/design_system.dart';

import 'core/di/injection.dart';
import 'core/router/hub_router.dart';
import 'core/bloc/hub_theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await BrandConfig.load();
  final locale = await LocaleManager.loadPersistedLocale();
  configureDependencies();
  runApp(HubApp(initialLocale: locale));
}

class HubApp extends StatelessWidget {
  final Locale? initialLocale;
  const HubApp({super.key, this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HubThemeBloc(BrandConfig.current)),
        BlocProvider(create: (_) => LocaleBloc(initialLocale ?? const Locale('en'))),
      ],
      child: BlocBuilder<HubThemeBloc, HubThemeState>(
        builder: (_, state) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: '${BrandConfig.current.appName} Hub',
          routerConfig: HubRouter.config,
          theme: state.lightTheme,
          darkTheme: state.darkTheme,
          themeMode: state.mode,
        ),
      ),
    );
  }
}
