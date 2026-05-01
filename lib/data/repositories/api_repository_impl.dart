import 'package:calorix_app/domain/models/request/complete_profile_request_model.dart';
import 'package:calorix_app/domain/models/request/send_otp_request_model.dart';
import 'package:calorix_app/domain/models/request/verify_otp_request_model.dart';
import 'package:calorix_app/domain/models/response/complete_profile_response_model.dart';
import 'package:calorix_app/domain/models/response/food_scan_response_model.dart';
import 'package:calorix_app/domain/models/response/get_agenda_response_model.dart';
import 'package:calorix_app/domain/models/response/send_otp_response_model.dart';
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
  Future<DataState<FoodScanResponseModel>> foodScan({
    required String token,
    required String image,
  }) {
    return getStateOf<FoodScanResponseModel>(
      request: () async {
        final file = await MultipartFile.fromFile(
          image,
          filename: image.split('/').last,
        );

        return _apiService.foodScan(
          token: token,
          image: file,
        );
      },
    );
  }
}
