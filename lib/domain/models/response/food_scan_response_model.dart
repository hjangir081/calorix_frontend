class FoodScanResponseModel {
  bool? hasErrors;
  int? statusCode;
  String? path;
  String? version;
  Result? result;
  int? id;
  List<ErrorModel>? errors;

  FoodScanResponseModel(
      {this.hasErrors,
        this.statusCode,
        this.path,
        this.version,
        this.result,
        this.id,
        this.errors});

  FoodScanResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? foodName;
  int? confidence;
  Nutrition? nutrition;

  Result({this.foodName, this.confidence, this.nutrition});

  Result.fromJson(Map<String, dynamic> json) {
    foodName = json['food_name'];
    confidence = json['confidence'];
    nutrition = json['nutrition'] != null
        ? new Nutrition.fromJson(json['nutrition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_name'] = this.foodName;
    data['confidence'] = this.confidence;
    if (this.nutrition != null) {
      data['nutrition'] = this.nutrition!.toJson();
    }
    return data;
  }
}

class Nutrition {
  int? calories;
  int? protein;
  int? carbs;
  int? fat;

  Nutrition({this.calories, this.protein, this.carbs, this.fat});

  Nutrition.fromJson(Map<String, dynamic> json) {
    calories = json['calories'];
    protein = json['protein'];
    carbs = json['carbs'];
    fat = json['fat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['calories'] = this.calories;
    data['protein'] = this.protein;
    data['carbs'] = this.carbs;
    data['fat'] = this.fat;
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