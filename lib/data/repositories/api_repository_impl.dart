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
import 'package:dio/dio.dart';

import '../../domain/repositories/api_repository.dart';
import '../core/data_state.dart';
import '../datasource/remote/api_service.dart';
import 'base/base_api_repository.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final ApiService _apiService;
  ApiRepositoryImpl(this._apiService);

  @override
  Future<DataState<SendOtpResponseModel>> sendOtp({required SendOtpRequestModel sendOtpRequestModel}) {
    // TODO: implement signIn
    return getStateOf<SendOtpResponseModel>(
      request: () => _apiService.sendOtp(sendOtpRequest: sendOtpRequestModel),
    );
  }

  @override
  Future<DataState<VerifyOtpResponseModel>> verifyOtp({required VerifyOtpRequestModel verifyOtpRequestModel}) {
    // TODO: implement signIn
    return getStateOf<VerifyOtpResponseModel>(
      request: () => _apiService.verifyOtp(verifyOtpRequest: verifyOtpRequestModel),
    );
  }

  @override
  Future<DataState<CompleteProfileResponseModel>> completeProfile({required CompleteProfileRequestModel completeProfileRequestModel, required String tempToken}) {
    // TODO: implement signIn
    return getStateOf<CompleteProfileResponseModel>(
      request: () => _apiService.completeProfile(completeProfileRequest: completeProfileRequestModel, tempToken: tempToken),
    );
  }

  @override
  Future<DataState<GetAgendaResponseModel>> getAgenda({required String token}) {
    // TODO: implement signIn
    return getStateOf<GetAgendaResponseModel>(
      request: () => _apiService.getAgenda(token: token),
    );
  }

  @override
  Future<DataState<FoodScanResponseModel>>
  foodScan({
    required String token,
    required String image,
  }) {

    return getStateOf<
        FoodScanResponseModel>(
      request: () async {

        final file =
        await MultipartFile
            .fromFile(
          image,
          filename:
          image.split('/').last,
        );

        final formData =
        FormData.fromMap({
          'image': file,
        });

        return _apiService.foodScan(
          token: token,
          formData: formData,
          extras: {
            'imagePath': image,
          },
        );
      },
    );
  }

  @override
  Future<DataState<LogFoodResponseModel>> logMeal({required LogFoodRequestModel logFoodRequestModel, required String token}) {
    // TODO: implement signIn
    return getStateOf<LogFoodResponseModel>(
      request: () => _apiService.logMeal(logFoodRequestModel: logFoodRequestModel,token: token),
    );
  }

  @override
  Future<DataState<LogoutResponseModel>> logout({required LogoutRequestModel logoutRequestModel, required String token}) {
    // TODO: implement signIn
    return getStateOf<LogoutResponseModel>(
      request: () => _apiService.logout(logoutRequestModel: logoutRequestModel,token: token),
    );
  }

  @override
  Future<DataState<GetHistoryResponseModel>> getHistory({required String token, required String date}) {
    // TODO: implement signIn
    return getStateOf<GetHistoryResponseModel>(
      request: () => _apiService.getHistory(token: token, date: date),
    );
  }

  @override
  Future<DataState<LeaderboardProgressResponseModel>> leaderboardProgress({required String token, required String days}) {
    // TODO: implement signIn
    return getStateOf<LeaderboardProgressResponseModel>(
      request: () => _apiService.leaderboardProgress(token: token, days: days),
    );
  }

  @override
  Future<DataState<GetNotificationResponseModel>> getNotification({required String token, required String limit, required String cursor}) {
    // TODO: implement signIn
    return getStateOf<GetNotificationResponseModel>(
      request: () => _apiService.getNotification(token: token, limit: limit, cursor: cursor),
    );
  }

  @override
  Future<DataState<UpdateGoalResponseModel>> updateGoal({required UpdateGoalRequestModel updateGoalRequestModel, required String token}) {
    // TODO: implement signIn
    return getStateOf<UpdateGoalResponseModel>(
      request: () => _apiService.updateGoal(token: token, updateGoalRequestModel: updateGoalRequestModel),
    );
  }

  @override
  Future<DataState<MealPreferenceOptionsResponseModel>> mealPreferenceOptions() {
    // TODO: implement signIn
    return getStateOf<MealPreferenceOptionsResponseModel>(
      request: () => _apiService.preferenceOptions(),
    );
  }

  @override
  Future<DataState<SuggestMealResponseModel>> suggestMeal({required String token}) {
    // TODO: implement signIn
    return getStateOf<SuggestMealResponseModel>(
      request: () => _apiService.suggestedMeal(token: token),
    );
  }
}
