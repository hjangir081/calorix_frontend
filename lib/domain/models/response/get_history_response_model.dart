import 'package:calorix_app/domain/models/response/complete_profile_response_model.dart';

class GetHistoryResponseModel {
  bool? hasErrors;
  int? statusCode;
  String? path;
  String? version;
  Result? result;
  int? id;
  List<ErrorModel>? errors;

  GetHistoryResponseModel(
      {this.hasErrors,
        this.statusCode,
        this.path,
        this.version,
        this.result,
        this.id,
        this.errors});

  GetHistoryResponseModel.fromJson(Map<String, dynamic> json) {
    hasErrors = json['HasErrors'];
    statusCode = json['StatusCode'];
    path = json['Path'];
    version = json['Version'];
    result =
    json['Result'] != null ? new Result.fromJson(json['Result']) : null;
    id = json['Id'];
    if (json['Errors'] != null) {
      errors = <ErrorModel>[];
      json['Errors'].forEach((v) {
        errors!.add(new ErrorModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['HasErrors'] = this.hasErrors;
    data['StatusCode'] = this.statusCode;
    data['Path'] = this.path;
    data['Version'] = this.version;
    if (this.result != null) {
      data['Result'] = this.result!.toJson();
    }
    data['Id'] = this.id;
    if (this.errors != null) {
      data['Errors'] = this.errors!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String? date;
  Summary? summary;
  Meals? meals;

  Result({this.date, this.summary, this.meals});

  Result.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    summary =
    json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    meals = json['meals'] != null ? new Meals.fromJson(json['meals']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.meals != null) {
      data['meals'] = this.meals!.toJson();
    }
    return data;
  }
}

class Summary {
  int? caloriesTarget;
  int? caloriesConsumed;
  int? remainingCalories;
  Protein? protein;
  Protein? carbs;
  Protein? fat;

  Summary(
      {this.caloriesTarget,
        this.caloriesConsumed,
        this.remainingCalories,
        this.protein,
        this.carbs,
        this.fat});

  Summary.fromJson(Map<String, dynamic> json) {
    caloriesTarget = json['calories_target'];
    caloriesConsumed = json['calories_consumed'];
    remainingCalories = json['remaining_calories'];
    protein =
    json['protein'] != null ? new Protein.fromJson(json['protein']) : null;
    carbs = json['carbs'] != null ? new Protein.fromJson(json['carbs']) : null;
    fat = json['fat'] != null ? new Protein.fromJson(json['fat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calories_target'] = this.caloriesTarget;
    data['calories_consumed'] = this.caloriesConsumed;
    data['remaining_calories'] = this.remainingCalories;
    if (this.protein != null) {
      data['protein'] = this.protein!.toJson();
    }
    if (this.carbs != null) {
      data['carbs'] = this.carbs!.toJson();
    }
    if (this.fat != null) {
      data['fat'] = this.fat!.toJson();
    }
    return data;
  }
}

class Protein {
  int? target;
  int? consumed;

  Protein({this.target, this.consumed});

  Protein.fromJson(Map<String, dynamic> json) {
    target = json['target'];
    consumed = json['consumed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['target'] = this.target;
    data['consumed'] = this.consumed;
    return data;
  }
}

class Meals {
  Breakfast? breakfast;
  Breakfast? lunch;
  Breakfast? dinner;
  Breakfast? snack;

  Meals({this.breakfast, this.lunch, this.dinner, this.snack});

  Meals.fromJson(Map<String, dynamic> json) {
    breakfast = json['breakfast'] != null
        ? new Breakfast.fromJson(json['breakfast'])
        : null;
    lunch =
    json['lunch'] != null ? new Breakfast.fromJson(json['lunch']) : null;
    dinner =
    json['dinner'] != null ? new Breakfast.fromJson(json['dinner']) : null;
    snack =
    json['snack'] != null ? new Breakfast.fromJson(json['snack']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breakfast != null) {
      data['breakfast'] = this.breakfast!.toJson();
    }
    if (this.lunch != null) {
      data['lunch'] = this.lunch!.toJson();
    }
    if (this.dinner != null) {
      data['dinner'] = this.dinner!.toJson();
    }
    if (this.snack != null) {
      data['snack'] = this.snack!.toJson();
    }
    return data;
  }
}

class Breakfast {
  int? totalCalories;
  List<Items>? items;

  Breakfast({this.totalCalories, this.items});

  Breakfast.fromJson(Map<String, dynamic> json) {
    totalCalories = json['total_calories'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_calories'] = this.totalCalories;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  int? id;
  String? foodName;
  String? imageUrl;
  int? calories;
  int? protein;
  int? carbs;
  int? fat;
  int? quantity;
  int? consumedPercentage;
  String? mealType;
  String? createdAt;

  Items(
      {this.id,
        this.foodName,
        this.imageUrl,
        this.calories,
        this.protein,
        this.carbs,
        this.fat,
        this.quantity,
        this.consumedPercentage,
        this.mealType,
        this.createdAt});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    foodName = json['food_name'];
    imageUrl = json['image_url'];
    calories = json['calories'];
    protein = json['protein'];
    carbs = json['carbs'];
    fat = json['fat'];
    quantity = json['quantity'];
    consumedPercentage = json['consumed_percentage'];
    mealType = json['meal_type'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['food_name'] = this.foodName;
    data['image_url'] = this.imageUrl;
    data['calories'] = this.calories;
    data['protein'] = this.protein;
    data['carbs'] = this.carbs;
    data['fat'] = this.fat;
    data['quantity'] = this.quantity;
    data['consumed_percentage'] = this.consumedPercentage;
    data['meal_type'] = this.mealType;
    data['created_at'] = this.createdAt;
    return data;
  }
}
