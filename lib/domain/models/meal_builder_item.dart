import '../../utils/services/common_functions.dart';

class MealBuilderItem {

  final String foodName;

  final String imageUrl;

  /// ORIGINAL VALUES

  final int baseCalories;

  final int baseProtein;

  final int baseCarbs;

  final int baseFat;

  final int baseWeightG;

  /// EDITABLE

  final int quantity;

  final int estimatedWeightG;

  const MealBuilderItem({

    required this.foodName,

    required this.imageUrl,

    required this.baseCalories,

    required this.baseProtein,

    required this.baseCarbs,

    required this.baseFat,

    required this.baseWeightG,

    required this.quantity,

    required this.estimatedWeightG,
  });

  /// LIVE VALUES

  int get calories {

    return NutritionCalculator.calculate(

      baseValue:
      baseCalories,

      baseWeight:
      baseWeightG,

      currentWeight:
      estimatedWeightG,

      quantity:
      quantity,
    );
  }

  int get protein {

    return NutritionCalculator.calculate(

      baseValue:
      baseProtein,

      baseWeight:
      baseWeightG,

      currentWeight:
      estimatedWeightG,

      quantity:
      quantity,
    );
  }

  int get carbs {

    return NutritionCalculator.calculate(

      baseValue:
      baseCarbs,

      baseWeight:
      baseWeightG,

      currentWeight:
      estimatedWeightG,

      quantity:
      quantity,
    );
  }

  int get fat {

    return NutritionCalculator.calculate(

      baseValue:
      baseFat,

      baseWeight:
      baseWeightG,

      currentWeight:
      estimatedWeightG,

      quantity:
      quantity,
    );
  }

  MealBuilderItem copyWith({

    String? foodName,

    String? imageUrl,

    int? baseCalories,

    int? baseProtein,

    int? baseCarbs,

    int? baseFat,

    int? baseWeightG,

    int? quantity,

    int? estimatedWeightG,
  }) {

    return MealBuilderItem(

      foodName:
      foodName ?? this.foodName,

      imageUrl:
      imageUrl ?? this.imageUrl,

      baseCalories:
      baseCalories ?? this.baseCalories,

      baseProtein:
      baseProtein ?? this.baseProtein,

      baseCarbs:
      baseCarbs ?? this.baseCarbs,

      baseFat:
      baseFat ?? this.baseFat,

      baseWeightG:
      baseWeightG ?? this.baseWeightG,

      quantity:
      quantity ?? this.quantity,

      estimatedWeightG:
      estimatedWeightG ??
          this.estimatedWeightG,
    );
  }
}