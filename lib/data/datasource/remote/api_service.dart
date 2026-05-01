import 'package:calorix_app/domain/models/request/complete_profile_request_model.dart';
import 'package:calorix_app/domain/models/request/send_otp_request_model.dart';
import 'package:calorix_app/domain/models/request/verify_otp_request_model.dart';
import 'package:calorix_app/domain/models/response/complete_profile_response_model.dart';
import 'package:calorix_app/domain/models/response/food_scan_response_model.dart';
import 'package:calorix_app/domain/models/response/get_agenda_response_model.dart';
import 'package:calorix_app/domain/models/response/send_otp_response_model.dart';
import 'package:calorix_app/domain/models/response/verify_otp_response_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
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
    @Part(name: 'image') required MultipartFile image,
  });
}
