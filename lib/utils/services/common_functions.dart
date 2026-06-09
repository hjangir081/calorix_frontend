import 'package:intl/intl.dart';

import '../constants/app_strings.dart';

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

  static String timeAgo(
      String? date,
      ) {

    if (date == null ||
        date.isEmpty) {

      return '';
    }

    final parsedDate =
    DateTime.parse(date)
        .toLocal();

    final difference =
    DateTime.now()
        .difference(parsedDate);

    if (difference.inSeconds <
        60) {

      return 'Just now';
    }

    if (difference.inMinutes <
        60) {

      return '${difference.inMinutes} min ago';
    }

    if (difference.inHours <
        24) {

      return '${difference.inHours} hr ago';
    }

    if (difference.inDays ==
        1) {

      return 'Yesterday';
    }

    if (difference.inDays <
        7) {

      return '${difference.inDays} days ago';
    }

    return DateFormat(
      'dd MMM',
    ).format(parsedDate);
  }

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

String getGoalTitle(
    String? goal,
    ) {

  switch (goal) {

    case GoalStrings.lose:
      return GoalStrings.loseWeight;

    case GoalStrings.maintain:
      return GoalStrings.maintainWeight;

    default:
      return GoalStrings.gainWeight;
  }
}

extension StringExtension
on String {

  String get capitalizeFirst {

    if (isEmpty) {
      return this;
    }

    return this[0]
        .toUpperCase() +
        substring(1)
            .toLowerCase();
  }
}
class NutritionCalculator {

  static int calculate({

    required int baseValue,

    required int baseWeight,

    required int currentWeight,

    required int quantity,
  }) {

    if (baseWeight == 0) {
      return 0;
    }

    final ratio =
        currentWeight / baseWeight;

    return (
        baseValue *
            ratio *
            quantity
    ).round();
  }
}
String mapGoalToApiValue(
    String value,
    ) {

  switch (value) {

    case 'Lose Weight':
      return 'lose';

    case 'Maintain Weight':
      return 'maintain';

    case 'Gain Muscle':
      return 'gain';

    default:
      return 'maintain';
  }
}