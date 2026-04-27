import 'package:flutter_riverpod/legacy.dart';

class SlidingState {
  final double dragPosition;
  final bool completed;

  SlidingState({this.dragPosition = 4, this.completed = false});

  SlidingState copyWith({double? dragPosition, bool? completed}) {
    return SlidingState(
      dragPosition: dragPosition ?? this.dragPosition,
      completed: completed ?? this.completed,
    );
  }
}

class SlidingController extends StateNotifier<SlidingState> {
  SlidingController() : super(SlidingState());

  void updateDrag(double dx, double maxDrag) {
    double newPos = state.dragPosition + dx;
    if (newPos < 0) newPos = 0;
    if (newPos > maxDrag) newPos = maxDrag;
    state = state.copyWith(dragPosition: newPos);
  }

  void reset() {
    state = SlidingState();
  }

  void animateToEnd(double maxDrag) {
    state = SlidingState(dragPosition: maxDrag, completed: true);
  }
}

final slidingProvider =
StateNotifierProvider<SlidingController, SlidingState>((ref) {
  return SlidingController();
});
