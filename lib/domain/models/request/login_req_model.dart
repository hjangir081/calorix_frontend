class LoginRequestModel {
  String? username;
  String? password;
  String? fcmToken;
  String? deviceType;
  bool? rememberMe;
  String? userType;

  LoginRequestModel(
      {this.username,
        this.password,
        this.fcmToken,
        this.deviceType,
        this.rememberMe,
        this.userType});

  LoginRequestModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    password = json['password'];
    fcmToken = json['fcmToken'];
    deviceType = json['deviceType'];
    rememberMe = json['rememberMe'];
    userType = json['userType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['password'] = this.password;
    data['fcmToken'] = this.fcmToken;
    data['deviceType'] = this.deviceType;
    data['rememberMe'] = this.rememberMe;
    data['userType'] = this.userType;
    return data;
  }
}
