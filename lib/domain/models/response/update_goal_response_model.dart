class UpdateGoalResponseModel {
  bool? hasErrors;
  int? statusCode;
  String? path;
  String? version;
  Result? result;
  int? id;
  List<ErrorModel>? errors;

  UpdateGoalResponseModel(
      {this.hasErrors,
        this.statusCode,
        this.path,
        this.version,
        this.result,
        this.id,
        this.errors});

  UpdateGoalResponseModel.fromJson(Map<String, dynamic> json) {
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
  GoalPlan? goalPlan;
  Target? target;

  Result({this.goal, this.goalPlan, this.target});

  Result.fromJson(Map<String, dynamic> json) {
    goal = json['goal'];
    goalPlan = json['goal_plan'] != null
        ? new GoalPlan.fromJson(json['goal_plan'])
        : null;
    target =
    json['target'] != null ? new Target.fromJson(json['target']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goal'] = this.goal;
    if (this.goalPlan != null) {
      data['goal_plan'] = this.goalPlan!.toJson();
    }
    if (this.target != null) {
      data['target'] = this.target!.toJson();
    }
    return data;
  }
}

class GoalPlan {
  int? targetWeightChange;
  int? durationValue;
  String? durationUnit;

  GoalPlan({this.targetWeightChange, this.durationValue, this.durationUnit});

  GoalPlan.fromJson(Map<String, dynamic> json) {
    targetWeightChange = json['target_weight_change'];
    durationValue = json['duration_value'];
    durationUnit = json['duration_unit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['target_weight_change'] = this.targetWeightChange;
    data['duration_value'] = this.durationValue;
    data['duration_unit'] = this.durationUnit;
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