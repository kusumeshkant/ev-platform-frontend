import 'package:intl/intl.dart';

abstract final class DateFormatter {
  static String ride(DateTime dt)       => DateFormat('d MMM yyyy, h:mm a').format(dt);
  static String short(DateTime dt)      => DateFormat('d MMM yyyy').format(dt);
  static String time(DateTime dt)       => DateFormat('h:mm a').format(dt);
  static String relative(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 1)  return 'Just now';
    if (diff.inHours < 1)    return '${diff.inMinutes}m ago';
    if (diff.inDays < 1)     return '${diff.inHours}h ago';
    if (diff.inDays < 7)     return '${diff.inDays}d ago';
    return short(dt);
  }

  static String duration(int totalSeconds) {
    final m = totalSeconds ~/ 60;
    final s = totalSeconds % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }
}
