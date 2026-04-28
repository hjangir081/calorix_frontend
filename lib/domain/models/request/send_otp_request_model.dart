class SendOtpRequestModel {
  String? countryCode;
  String? phoneNumber;

  SendOtpRequestModel({this.countryCode, this.phoneNumber});

  SendOtpRequestModel.fromJson(Map<String, dynamic> json) {
    countryCode = json['country_code'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['country_code'] = this.countryCode;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}
