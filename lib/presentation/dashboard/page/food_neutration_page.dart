import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:calorix_app/config/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import '../../../domain/models/response/food_scan_response_model.dart';

@RoutePage()
class FoodNutrientsPage extends StatelessWidget {
  final FoodScanResponseModel data;

  const FoodNutrientsPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final result = data.result;

    return Scaffold(
      appBar: AppBar(leading: GestureDetector(child: Icon(Icons.arrow_back_ios_new_rounded), onTap: () => context.router.replaceAll([const DashboardRoute()]),),title: const Text("Food Details")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              result?.foodName ?? "Unknown",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            _item("Calories", result?.nutrition?.calories),
            _item("Protein", result?.nutrition?.protein),
            _item("Carbs", result?.nutrition?.carbs),
            _item("Fat", result?.nutrition?.fat),
          ],
        ),
      ),
    );
  }

  Widget _item(String title, dynamic value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text("${value ?? 0}"),
        ],
      ),
    );
  }
}