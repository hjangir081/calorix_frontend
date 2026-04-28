class VerifyOtpRequestModel {
  String? countryCode;
  String? phoneNumber;
  String? otp;
  String? deviceType;
  String? fcmToken;

  VerifyOtpRequestModel(
      {this.countryCode,
        this.phoneNumber,
        this.otp,
        this.deviceType,
        this.fcmToken});

  VerifyOtpRequestModel.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
    otp = json['otp'];
    deviceType = json['device_type'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    data['otp'] = this.otp;
    data['device_type'] = this.deviceType;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}
