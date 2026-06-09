class LeaderboardProgressResponseModel {
  bool? hasErrors;
  int? statusCode;
  String? path;
  String? version;
  Result? result;
  int? id;
  List<ErrorModel>? errors;

  LeaderboardProgressResponseModel(
      {this.hasErrors,
        this.statusCode,
        this.path,
        this.version,
        this.result,
        this.id,
        this.errors});

  LeaderboardProgressResponseModel.fromJson(Map<String, dynamic> json) {
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
  int? periodDays;
  Summary? summary;
  Chart? chart;

  Result({this.periodDays, this.summary, this.chart});

  Result.fromJson(Map<String, dynamic> json) {
    periodDays = json['period_days'];
    summary =
    json['summary'] != null ? new Summary.fromJson(json['summary']) : null;
    chart = json['chart'] != null ? new Chart.fromJson(json['chart']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['period_days'] = this.periodDays;
    if (this.summary != null) {
      data['summary'] = this.summary!.toJson();
    }
    if (this.chart != null) {
      data['chart'] = this.chart!.toJson();
    }
    return data;
  }
}

class Summary {
  int? avgAdherencePct;
  int? daysLogged;
  int? currentLoggingStreak;
  int? bestLoggingStreak;

  Summary(
      {this.avgAdherencePct,
        this.daysLogged,
        this.currentLoggingStreak,
        this.bestLoggingStreak});

  Summary.fromJson(Map<String, dynamic> json) {
    avgAdherencePct = json['avg_adherence_pct'];
    daysLogged = json['days_logged'];
    currentLoggingStreak = json['current_logging_streak'];
    bestLoggingStreak = json['best_logging_streak'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg_adherence_pct'] = this.avgAdherencePct;
    data['days_logged'] = this.daysLogged;
    data['current_logging_streak'] = this.currentLoggingStreak;
    data['best_logging_streak'] = this.bestLoggingStreak;
    return data;
  }
}

class Chart {
  List<String>? labels;
  List<Datasets>? datasets;

  Chart({this.labels, this.datasets});

  Chart.fromJson(Map<String, dynamic> json) {
    labels = json['labels'].cast<String>();
    if (json['datasets'] != null) {
      datasets = <Datasets>[];
      json['datasets'].forEach((v) {
        datasets!.add(new Datasets.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['labels'] = this.labels;
    if (this.datasets != null) {
      data['datasets'] = this.datasets!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Datasets {
  String? key;
  String? label;
  List<int>? data;

  Datasets({this.key, this.label, this.data});

  Datasets.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    label = json['label'];
    data = json['data'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['label'] = this.label;
    data['data'] = this.data;
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