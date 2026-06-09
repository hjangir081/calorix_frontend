class SuggestMealResponseModel {
  bool? hasErrors;
  int? statusCode;
  String? path;
  String? version;
  Result? result;
  int? id;
  List<ErrorModel>? errors;

  SuggestMealResponseModel(
      {this.hasErrors,
        this.statusCode,
        this.path,
        this.version,
        this.result,
        this.id,
        this.errors});

  SuggestMealResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<MealItems>? breakfast;
  List<MealItems>? morningSnack;
  List<MealItems>? lunch;
  List<MealItems>? eveningSnack;
  List<MealItems>? dinner;

  Result(
      {this.breakfast,
        this.morningSnack,
        this.lunch,
        this.eveningSnack,
        this.dinner});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['breakfast'] != null) {
      breakfast = <MealItems>[];
      json['breakfast'].forEach((v) {
        breakfast!.add(new MealItems.fromJson(v));
      });
    }
    if (json['morning_snack'] != null) {
      morningSnack = <MealItems>[];
      json['morning_snack'].forEach((v) {
        morningSnack!.add(new MealItems.fromJson(v));
      });
    }
    if (json['lunch'] != null) {
      lunch = <MealItems>[];
      json['lunch'].forEach((v) {
        lunch!.add(new MealItems.fromJson(v));
      });
    }
    if (json['evening_snack'] != null) {
      eveningSnack = <MealItems>[];
      json['evening_snack'].forEach((v) {
        eveningSnack!.add(new MealItems.fromJson(v));
      });
    }
    if (json['dinner'] != null) {
      dinner = <MealItems>[];
      json['dinner'].forEach((v) {
        dinner!.add(new MealItems.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.breakfast != null) {
      data['breakfast'] = this.breakfast!.map((v) => v.toJson()).toList();
    }
    if (this.morningSnack != null) {
      data['morning_snack'] =
          this.morningSnack!.map((v) => v.toJson()).toList();
    }
    if (this.lunch != null) {
      data['lunch'] = this.lunch!.map((v) => v.toJson()).toList();
    }
    if (this.eveningSnack != null) {
      data['evening_snack'] =
          this.eveningSnack!.map((v) => v.toJson()).toList();
    }
    if (this.dinner != null) {
      data['dinner'] = this.dinner!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MealItems {
  String? name;
  String? quantity;
  int? calories;
  int? protein;
  int? carbs;
  int? fat;
  List<Ingredients>? ingredients;
  List<String>? instructions;

  MealItems(
      {this.name,
        this.quantity,
        this.calories,
        this.protein,
        this.carbs,
        this.fat,
        this.ingredients,
        this.instructions});

  MealItems.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
    calories = json['calories'];
    protein = json['protein'];
    carbs = json['carbs'];
    fat = json['fat'];
    if (json['ingredients'] != null) {
      ingredients = <Ingredients>[];
      json['ingredients'].forEach((v) {
        ingredients!.add(new Ingredients.fromJson(v));
      });
    }
    instructions = json['instructions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    data['calories'] = this.calories;
    data['protein'] = this.protein;
    data['carbs'] = this.carbs;
    data['fat'] = this.fat;
    if (this.ingredients != null) {
      data['ingredients'] = this.ingredients!.map((v) => v.toJson()).toList();
    }
    data['instructions'] = this.instructions;
    return data;
  }
}

class Ingredients {
  String? name;
  String? quantity;

  Ingredients({this.name, this.quantity});

  Ingredients.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['quantity'] = this.quantity;
    return data;
  }
}
class ErrorModel {
  String? message;
  dynamic data;

  ErrorModel({this.message, this.data});

  ErrorModel.fromJson(Map<String, dynamic> json) {
    message = json['Message'];
    data = json['Data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> dataMap = {};
    dataMap['Message'] = message;
    dataMap['Data'] = data;
    return dataMap;
  }
}