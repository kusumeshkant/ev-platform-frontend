import 'package:flutter/foundation.dart';

enum _Level { debug, info, warning, error }

abstract final class AppLogger {
  static void debug(String msg)                                  => _log(_Level.debug,   msg);
  static void info(String msg)                                   => _log(_Level.info,    msg);
  static void warning(String msg, [Object? err, StackTrace? st]) => _log(_Level.warning, msg, err, st);
  static void error(String msg,   [Object? err, StackTrace? st]) => _log(_Level.error,   msg, err, st);

  static void _log(_Level level, String msg, [Object? err, StackTrace? st]) {
    if (!kDebugMode && level == _Level.debug) return;

    final prefix = switch (level) {
      _Level.debug   => '🔍',
      _Level.info    => 'ℹ️',
      _Level.warning => '⚠️',
      _Level.error   => '🔴',
    };
    debugPrint('$prefix [EV] $msg${err != null ? '\n$err' : ''}${st != null ? '\n$st' : ''}');
  }
}
