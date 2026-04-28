class CompleteProfileRequestModel {
  String? firstName;
  String? lastName;
  String? email;
  String? dob;
  String? gender;
  int? weight;
  int? height;
  String? goal;
  String? deviceType;
  String? fcmToken;

  CompleteProfileRequestModel(
      {this.firstName,
        this.lastName,
        this.email,
        this.dob,
        this.gender,
        this.weight,
        this.height,
        this.goal,
        this.deviceType,
        this.fcmToken});

  CompleteProfileRequestModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    weight = json['weight'];
    height = json['height'];
    goal = json['goal'];
    deviceType = json['device_type'];
    fcmToken = json['fcm_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['weight'] = this.weight;
    data['height'] = this.height;
    data['goal'] = this.goal;
    data['device_type'] = this.deviceType;
    data['fcm_token'] = this.fcmToken;
    return data;
  }
}
