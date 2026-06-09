class UpdateGoalRequestModel {

  String? goal;
  double? targetWeightChange;
  int? durationValue;
  String? durationUnit;

  UpdateGoalRequestModel({
    this.goal,
    this.targetWeightChange,
    this.durationValue,
    this.durationUnit,
  });

  UpdateGoalRequestModel.fromJson(
      Map<String, dynamic> json,
      ) {
    goal = json['goal'];

    targetWeightChange =
    json['target_weight_change'] != null
        ? (json['target_weight_change'] as num).toDouble()
        : null;

    durationValue = json['duration_value'];

    durationUnit = json['duration_unit'];
  }

  Map<String, dynamic> toJson() {

    final Map<String, dynamic> data = {};

    data['goal'] = goal;

    /// ONLY SEND FOR LOSE/GAIN
    if (goal != 'maintain') {

      data['target_weight_change'] =
          targetWeightChange;

      data['duration_value'] =
          durationValue;

      data['duration_unit'] =
          durationUnit;
    }

    return data;
  }
}