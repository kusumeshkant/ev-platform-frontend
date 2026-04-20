import 'package:flutter/material.dart';

abstract final class SupportedLocales {
  static const en = Locale('en');
  static const hi = Locale('hi');
  static const ta = Locale('ta');
  static const te = Locale('te');
  static const kn = Locale('kn');

  static const all = [en, hi, ta, te, kn];

  static Locale? fromCode(String code) {
    return all.where((l) => l.languageCode == code).firstOrNull;
  }

  static String displayName(Locale locale) => switch (locale.languageCode) {
    'en' => 'English',
    'hi' => 'हिन्दी',
    'ta' => 'தமிழ்',
    'te' => 'తెలుగు',
    'kn' => 'ಕನ್ನಡ',
    _    => locale.languageCode,
  };
}
