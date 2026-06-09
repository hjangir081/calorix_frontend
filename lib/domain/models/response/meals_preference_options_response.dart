class MealPreferenceOptionsResponseModel {
  bool? hasErrors;
  int? statusCode;
  String? path;
  String? version;
  Result? result;
  int? id;
  List<ErrorModel>? errors;

  MealPreferenceOptionsResponseModel(
      {this.hasErrors,
        this.statusCode,
        this.path,
        this.version,
        this.result,
        this.id,
        this.errors});

  MealPreferenceOptionsResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<DietTypes>? dietTypes;
  List<Cuisines>? cuisines;

  Result({this.dietTypes, this.cuisines});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['diet_types'] != null) {
      dietTypes = <DietTypes>[];
      json['diet_types'].forEach((v) {
        dietTypes!.add(new DietTypes.fromJson(v));
      });
    }
    if (json['cuisines'] != null) {
      cuisines = <Cuisines>[];
      json['cuisines'].forEach((v) {
        cuisines!.add(new Cuisines.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dietTypes != null) {
      data['diet_types'] = this.dietTypes!.map((v) => v.toJson()).toList();
    }
    if (this.cuisines != null) {
      data['cuisines'] = this.cuisines!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DietTypes {
  String? id;
  String? title;

  DietTypes({this.id, this.title});

  DietTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    return data;
  }
}
class Cuisines {
  String? id;
  String? title;

  Cuisines({this.id, this.title});

  Cuisines.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
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