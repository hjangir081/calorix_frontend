class GetAgendaResponseModel {
  bool? hasErrors;
  int? statusCode;
  String? path;
  String? version;
  Result? result;
  int? id;
  List<ErrorModel>? errors;

  GetAgendaResponseModel(
      {this.hasErrors,
        this.statusCode,
        this.path,
        this.version,
        this.result,
        this.id,
        this.errors});

  GetAgendaResponseModel.fromJson(Map<String, dynamic> json) {
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
  String? goal;
  Target? target;
  Target? consumed;
  Target? remaining;
  OverLimits? overLimits;

  Result(
      {this.goal, this.target, this.consumed, this.remaining, this.overLimits});

  Result.fromJson(Map<String, dynamic> json) {
    goal = json['goal'];
    target =
    json['target'] != null ? new Target.fromJson(json['target']) : null;
    consumed =
    json['consumed'] != null ? new Target.fromJson(json['consumed']) : null;
    remaining = json['remaining'] != null
        ? new Target.fromJson(json['remaining'])
        : null;
    overLimits = json['overLimits'] != null
        ? new OverLimits.fromJson(json['overLimits'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goal'] = this.goal;
    if (this.target != null) {
      data['target'] = this.target!.toJson();
    }
    if (this.consumed != null) {
      data['consumed'] = this.consumed!.toJson();
    }
    if (this.remaining != null) {
      data['remaining'] = this.remaining!.toJson();
    }
    if (this.overLimits != null) {
      data['overLimits'] = this.overLimits!.toJson();
    }
    return data;
  }
}

class Target {
  int? calories;
  int? protein;
  int? carbs;
  int? fat;

  Target({this.calories, this.protein, this.carbs, this.fat});

  Target.fromJson(Map<String, dynamic> json) {
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

class OverLimits {
  Calories? calories;
  Calories? protein;
  Calories? carbs;
  Calories? fat;

  OverLimits({this.calories, this.protein, this.carbs, this.fat});

  OverLimits.fromJson(Map<String, dynamic> json) {
    calories = json['calories'] != null
        ? new Calories.fromJson(json['calories'])
        : null;
    protein =
    json['protein'] != null ? new Calories.fromJson(json['protein']) : null;
    carbs = json['carbs'] != null ? new Calories.fromJson(json['carbs']) : null;
    fat = json['fat'] != null ? new Calories.fromJson(json['fat']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.calories != null) {
      data['calories'] = this.calories!.toJson();
    }
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

class Calories {
  bool? isOverLimit;
  int? overLimitAmount;

  Calories({this.isOverLimit, this.overLimitAmount});

  Calories.fromJson(Map<String, dynamic> json) {
    isOverLimit = json['isOverLimit'];
    overLimitAmount = json['overLimitAmount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isOverLimit'] = this.isOverLimit;
    data['overLimitAmount'] = this.overLimitAmount;
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