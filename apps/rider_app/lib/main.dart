import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:brand_config/brand_config.dart';
import 'package:localization/localization.dart';
import 'package:design_system/design_system.dart';

import 'core/di/injection.dart';
import 'core/router/app_router.dart';
import 'core/bloc/theme_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Lock to portrait by default
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Brand config
  await BrandConfig.load();

  // Persisted locale
  final locale = await LocaleManager.loadPersistedLocale();

  // Dependency injection
  configureDependencies();

  // Firebase
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(RiderApp(initialLocale: locale));
}

class RiderApp extends StatelessWidget {
  final Locale? initialLocale;
  const RiderApp({super.key, this.initialLocale});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc(BrandConfig.current)),
        BlocProvider(create: (_) => LocaleBloc(initialLocale ?? const Locale('en'))),
      ],
      child: const _AppView(),
    );
  }
}

class _AppView extends StatelessWidget {
  const _AppView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<LocaleBloc, LocaleState>(
          builder: (context, localeState) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: BrandConfig.current.appName,
              routerConfig: AppRouter.config,
              theme:      themeState.lightTheme,
              darkTheme:  themeState.darkTheme,
              themeMode:  themeState.mode,
              locale:     localeState.locale,
              // Localization delegates — enabled after flutter gen-l10n
              // localizationsDelegates: AppLocalizations.localizationsDelegates,
              // supportedLocales: AppLocalizations.supportedLocales,
            );
          },
        );
      },
    );
  }
}
