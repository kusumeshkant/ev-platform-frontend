import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'supported_locales.dart';

abstract final class LocaleManager {
  static const _key = 'ev_locale';

  static Future<Locale?> loadPersistedLocale() async {
    final prefs  = await SharedPreferences.getInstance();
    final code   = prefs.getString(_key);
    if (code == null) return null;
    return SupportedLocales.fromCode(code);
  }

  static Future<void> persist(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, locale.languageCode);
  }
}
