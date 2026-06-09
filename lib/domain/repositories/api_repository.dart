import 'package:calorix_app/domain/models/request/complete_profile_request_model.dart';
import 'package:calorix_app/domain/models/request/log_food_request_model.dart';
import 'package:calorix_app/domain/models/request/logout_request_model.dart';
import 'package:calorix_app/domain/models/request/send_otp_request_model.dart';
import 'package:calorix_app/domain/models/request/update_goal_request_model.dart';
import 'package:calorix_app/domain/models/request/verify_otp_request_model.dart';
import 'package:calorix_app/domain/models/response/complete_profile_response_model.dart';
import 'package:calorix_app/domain/models/response/food_scan_response_model.dart';
import 'package:calorix_app/domain/models/response/get_agenda_response_model.dart';
import 'package:calorix_app/domain/models/response/get_history_response_model.dart';
import 'package:calorix_app/domain/models/response/get_notification_response_model.dart';
import 'package:calorix_app/domain/models/response/leaderboard_progress_response_model.dart';
import 'package:calorix_app/domain/models/response/log_meal_response_model.dart';
import 'package:calorix_app/domain/models/response/logout_response_model.dart';
import 'package:calorix_app/domain/models/response/meals_preference_options_response.dart';
import 'package:calorix_app/domain/models/response/send_otp_response_model.dart';
import 'package:calorix_app/domain/models/response/suggest_meal_response_model.dart';
import 'package:calorix_app/domain/models/response/update_goal_response_model.dart';
import 'package:calorix_app/domain/models/response/verify_otp_response_model.dart';

import '../../data/core/data_state.dart';

abstract class ApiRepository{
  Future<DataState<SendOtpResponseModel>> sendOtp({required SendOtpRequestModel sendOtpRequestModel});
  Future<DataState<VerifyOtpResponseModel>> verifyOtp({required VerifyOtpRequestModel verifyOtpRequestModel});
  Future<DataState<CompleteProfileResponseModel>> completeProfile({required CompleteProfileRequestModel completeProfileRequestModel, required String tempToken});
  Future<DataState<MealPreferenceOptionsResponseModel>> mealPreferenceOptions();
  Future<DataState<GetAgendaResponseModel>> getAgenda({required String token});
  Future<DataState<FoodScanResponseModel>> foodScan({required String token, required String image});
  Future<DataState<LogFoodResponseModel>> logMeal({required LogFoodRequestModel logFoodRequestModel, required String token});
  Future<DataState<LogoutResponseModel>> logout({required LogoutRequestModel logoutRequestModel, required String token});
  Future<DataState<GetHistoryResponseModel>> getHistory({required String token, required String date});
  Future<DataState<LeaderboardProgressResponseModel>> leaderboardProgress({required String token, required String days});
  Future<DataState<GetNotificationResponseModel>> getNotification({required String token, required String limit, required String cursor});
  Future<DataState<UpdateGoalResponseModel>> updateGoal({required UpdateGoalRequestModel updateGoalRequestModel, required String token});
  Future<DataState<SuggestMealResponseModel>> suggestMeal({required String token});
}
