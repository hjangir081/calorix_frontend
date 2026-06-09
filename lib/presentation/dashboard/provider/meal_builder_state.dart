

import '../../../domain/models/meal_builder_item.dart';

class MealBuilderState {

  final List<MealBuilderItem>
  items;

  const MealBuilderState({

    this.items = const [],
  });

  MealBuilderState copyWith({

    List<MealBuilderItem>?
    items,
  }) {

    return MealBuilderState(

      items:
      items ?? this.items,
    );
  }

  /// TOTALS

  int get totalCalories {

    return items.fold(

      0,

          (sum, item) =>
      sum +
          (item.calories *
              item.quantity),
    );
  }

  int get totalProtein {

    return items.fold(

      0,

          (sum, item) =>
      sum +
          (item.protein *
              item.quantity),
    );
  }

  int get totalCarbs {

    return items.fold(

      0,

          (sum, item) =>
      sum +
          (item.carbs *
              item.quantity),
    );
  }

  int get totalFat {

    return items.fold(

      0,

          (sum, item) =>
      sum +
          (item.fat *
              item.quantity),
    );
  }
}