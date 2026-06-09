import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../domain/models/meal_builder_item.dart';

import 'meal_builder_state.dart';

final mealBuilderProvider =
StateNotifierProvider<
    MealBuilderNotifier,
    MealBuilderState>(

      (ref) {

    return MealBuilderNotifier();
  },
);

class MealBuilderNotifier
    extends StateNotifier<
        MealBuilderState> {

  MealBuilderNotifier()
      : super(
    const MealBuilderState(),
  );

  /// ADD ITEM

  void addItem(
      MealBuilderItem item,
      ) {

    state = state.copyWith(

      items: [

        ...state.items,

        item,
      ],
    );
  }

  /// REMOVE ITEM

  void removeItem(
      int index,
      ) {

    final updated =
    [...state.items];

    updated.removeAt(index);

    state = state.copyWith(
      items: updated,
    );
  }

  /// UPDATE QUANTITY

  void updateQuantity({

    required int index,

    required int quantity,
  }) {

    final updated =
    [...state.items];

    updated[index] =
        updated[index].copyWith(

          quantity: quantity,
        );

    state = state.copyWith(
      items: updated,
    );
  }

  /// UPDATE WEIGHT

  void updateWeight({

    required int index,

    required int grams,
  }) {

    final updated =
    [...state.items];

    updated[index] =
        updated[index].copyWith(

          estimatedWeightG:
          grams,
        );

    state = state.copyWith(
      items: updated,
    );
  }

  /// CLEAR

  void clearMeal() {

    state =
    const MealBuilderState();
  }
}