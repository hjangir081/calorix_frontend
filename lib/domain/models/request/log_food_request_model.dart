class LogFoodRequestModel {
  String? mealType;
  List<Items>? items;

  LogFoodRequestModel({this.mealType, this.items});

  LogFoodRequestModel.fromJson(Map<String, dynamic> json) {
    mealType = json['meal_type'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['meal_type'] = this.mealType;
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? foodName;
  String? imageUrl;
  int? calories;
  int? protein;
  int? carbs;
  int? fat;
  int? quantity;
  double? confidence;

  Items(
      {this.foodName,
        this.imageUrl,
        this.calories,
        this.protein,
        this.carbs,
        this.fat,
        this.quantity,
        this.confidence});

  Items.fromJson(Map<String, dynamic> json) {
    foodName = json['food_name'];
    imageUrl = json['image_url'];
    calories = json['calories'];
    protein = json['protein'];
    carbs = json['carbs'];
    fat = json['fat'];
    quantity = json['quantity'];
    confidence = json['confidence'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['food_name'] = this.foodName;
    data['image_url'] = this.imageUrl;
    data['calories'] = this.calories;
    data['protein'] = this.protein;
    data['carbs'] = this.carbs;
    data['fat'] = this.fat;
    data['quantity'] = this.quantity;
    data['confidence'] = this.confidence;
    return data;
  }
}
