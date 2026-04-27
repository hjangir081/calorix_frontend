import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class CalorieState {
  final int consumed;
  final int goal;
  CalorieState({required this.consumed, required this.goal});
}

// Riverpod provider
final calorieProvider = StateProvider<CalorieState>((ref) {
  return CalorieState(consumed: 1721, goal: 2213);
});
