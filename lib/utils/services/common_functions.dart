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
