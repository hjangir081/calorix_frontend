class LogoutRequestModel {
  String? deviceType;

  LogoutRequestModel({this.deviceType});

  LogoutRequestModel.fromJson(Map<String, dynamic> json) {
    deviceType = json['device_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['device_type'] = this.deviceType;
    return data;
  }
}
