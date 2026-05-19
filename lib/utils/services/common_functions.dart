import 'package:intl/intl.dart';

String getGreeting({DateTime? now,}) {
  final DateTime time = now ?? DateTime.now();
  final int hour = time.hour;

  String base;
  if (hour >= 5 && hour < 12) {
    base = 'Good morning';
  } else if (hour >= 12 && hour < 17) {
    base = 'Good afternoon';
  } else if (hour >= 17 && hour < 21) {
    base = 'Good evening';
  } else {
    base = 'Good night';
  }
  return '$base,';
}


class AppDateFormatter {

  static String formatDateForApi(
      DateTime date,
      ) {

    return DateFormat(
      'yyyy-MM-dd',
    ).format(date);
  }

  static String getDayName(
      DateTime date,
      ) {

    return DateFormat(
      'EEE',
    ).format(date);
  }

  static String formatDate(
      String? date,
      ) {

    if (date == null ||
        date.isEmpty) {

      return 'N/A';
    }

    final parsedDate =
    DateTime.parse(date);

    final now =
    DateTime.now();

    final today =
    DateTime(
      now.year,
      now.month,
      now.day,
    );

    final target =
    DateTime(
      parsedDate.year,
      parsedDate.month,
      parsedDate.day,
    );

    final difference =
        target.difference(today)
            .inDays;

    if (difference == 0) {
      return 'Today';
    }

    if (difference == -1) {
      return 'Yesterday';
    }

    if (difference == 1) {
      return 'Tomorrow';
    }

    return DateFormat(
      'EEEE dd, yyyy',
    ).format(parsedDate);
  }
}