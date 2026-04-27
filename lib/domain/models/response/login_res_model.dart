class LoginResponseModel {
  bool? hasErrors;
  int? statusCode;
  String? path;
  String? version;
  Result? result;
  String? id;
  String? errors;

  LoginResponseModel(
      {this.hasErrors,
        this.statusCode,
        this.path,
        this.version,
        this.result,
        this.id,
        this.errors});

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    hasErrors = json['HasErrors'];
    statusCode = json['StatusCode'];
    path = json['Path'];
    version = json['Version'];
    result =
    json['Result'] != null ? new Result.fromJson(json['Result']) : null;
    id = json['Id'];
    errors = json['Errors'];
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
    data['Errors'] = this.errors;
    return data;
  }
}

class Result {
  bool? isSuccess;
  Data? data;
  String? message;

  Result({this.isSuccess, this.data, this.message});

  Result.fromJson(Map<String, dynamic> json) {
    isSuccess = json['isSuccess'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['isSuccess'] = this.isSuccess;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? role;
  AuthToken? authToken;
  int? loggedInUser;
  String? customerGuid;
  String? firstName;
  String? lastName;
  String? email;

  Data(
      {this.role,
        this.authToken,
        this.loggedInUser,
        this.customerGuid,
        this.firstName,
        this.lastName,
        this.email});

  Data.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    authToken = json['authToken'] != null
        ? new AuthToken.fromJson(json['authToken'])
        : null;
    loggedInUser = json['loggedInUser'];
    customerGuid = json['customerGuid'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role'] = this.role;
    if (this.authToken != null) {
      data['authToken'] = this.authToken!.toJson();
    }
    data['loggedInUser'] = this.loggedInUser;
    data['customerGuid'] = this.customerGuid;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['email'] = this.email;
    return data;
  }
}

class AuthToken {
  String? accessToken;
  RefreshToken? refreshToken;
  String? userName;

  AuthToken({this.accessToken, this.refreshToken, this.userName});

  AuthToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    refreshToken = json['refreshToken'] != null
        ? new RefreshToken.fromJson(json['refreshToken'])
        : null;
    userName = json['userName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    if (this.refreshToken != null) {
      data['refreshToken'] = this.refreshToken!.toJson();
    }
    data['userName'] = this.userName;
    return data;
  }
}

class RefreshToken {
  String? username;
  String? tokenString;

  RefreshToken({this.username, this.tokenString});

  RefreshToken.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    tokenString = json['tokenString'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['tokenString'] = this.tokenString;
    return data;
  }
}
