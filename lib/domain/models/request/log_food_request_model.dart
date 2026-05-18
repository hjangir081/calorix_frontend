class LogFoodRequestModel {
  String? imageUrl;
  String? foodName;
  int? calories;
  int? protein;
  int? carbs;
  int? fat;
  String? mealType;
  int? quantity;
  int? consumedPercentage;

  LogFoodRequestModel(
      {this.imageUrl,
        this.foodName,
        this.calories,
        this.protein,
        this.carbs,
        this.fat,
        this.mealType,
        this.quantity,
        this.consumedPercentage});

  LogFoodRequestModel.fromJson(Map<String, dynamic> json) {
    imageUrl = json['image_url'];
    foodName = json['food_name'];
    calories = json['calories'];
    protein = json['protein'];
    carbs = json['carbs'];
    fat = json['fat'];
    mealType = json['meal_type'];
    quantity = json['quantity'];
    consumedPercentage = json['consumed_percentage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image_url'] = this.imageUrl;
    data['food_name'] = this.foodName;
    data['calories'] = this.calories;
    data['protein'] = this.protein;
    data['carbs'] = this.carbs;
    data['fat'] = this.fat;
    data['meal_type'] = this.mealType;
    data['quantity'] = this.quantity;
    data['consumed_percentage'] = this.consumedPercentage;
    return data;
  }
}
