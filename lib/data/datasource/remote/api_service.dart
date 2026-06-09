import 'package:calorix_app/domain/models/request/complete_profile_request_model.dart';
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
import 'package:retrofit/retrofit.dart';
import '../../../domain/models/request/log_food_request_model.dart';
import '../../../utils/constants/api_environment.dart';

part 'api_service.g.dart';

@RestApi(
  baseUrl: ApiEnvironment.baseUrl + ApiEnvironment.apiPrefix,
  parser: Parser.JsonSerializable,
)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiEnvironment.sendOtp)
  Future<HttpResponse<SendOtpResponseModel>> sendOtp({
    @Body() required SendOtpRequestModel sendOtpRequest,
  });

  @POST(ApiEnvironment.verifyOtp)
  Future<HttpResponse<VerifyOtpResponseModel>> verifyOtp({
    @Body() required VerifyOtpRequestModel verifyOtpRequest,
  });

  @POST(ApiEnvironment.completeProfile)
  Future<HttpResponse<CompleteProfileResponseModel>> completeProfile({
    @Body() required CompleteProfileRequestModel completeProfileRequest,
    @Header('Authorization') String? tempToken,
  });

  @GET(ApiEnvironment.getAgenda)
  Future<HttpResponse<GetAgendaResponseModel>> getAgenda({
    @Header('Authorization') String? token,
  });

  @MultiPart()
  @POST(ApiEnvironment.foodScan)
  Future<HttpResponse<FoodScanResponseModel>> foodScan({
    @Header('Authorization') String? token,
    @Body() required FormData formData,
    @Extras() Map<String, dynamic>? extras,
  });

  @POST(ApiEnvironment.logMeal)
  Future<HttpResponse<LogFoodResponseModel>> logMeal({
    @Header('Authorization') String? token,
    @Body() required LogFoodRequestModel logFoodRequestModel,
  });

  @POST(ApiEnvironment.logout)
  Future<HttpResponse<LogoutResponseModel>> logout({
    @Header('Authorization') String? token,
    @Body() required LogoutRequestModel logoutRequestModel,
  });

  @GET(ApiEnvironment.getHistory)
  Future<HttpResponse<GetHistoryResponseModel>> getHistory({
    @Header('Authorization') String? token,
    @Query('date') required String date,
  });

  @GET(ApiEnvironment.leaderboardProgress)
  Future<HttpResponse<LeaderboardProgressResponseModel>> leaderboardProgress({
    @Header('Authorization') String? token,
    @Query('period_days') required String days,
  });

  @GET(ApiEnvironment.getNotification)
  Future<HttpResponse<GetNotificationResponseModel>> getNotification({
    @Header('Authorization') String? token,
    @Query('limit') required String limit,
    @Query('cursor') required String cursor,
  });

  @PATCH(ApiEnvironment.updateGoal)
  Future<HttpResponse<UpdateGoalResponseModel>> updateGoal({
    @Header('Authorization') String? token,
    @Body() required UpdateGoalRequestModel updateGoalRequestModel,
  });

  @GET(ApiEnvironment.preferenceOptions)
  Future<HttpResponse<MealPreferenceOptionsResponseModel>> preferenceOptions();

  @GET(ApiEnvironment.suggestMeal)
  Future<HttpResponse<SuggestMealResponseModel>> suggestedMeal({
    @Header('Authorization') String? token,
  });
}
