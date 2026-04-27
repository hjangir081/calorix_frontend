/*
import '../../domain/repositories/api_repository.dart';
import '../core/data_state.dart';
import '../datasource/remote/api_service.dart';
import 'base/base_api_repository.dart';

class ApiRepositoryImpl extends BaseApiRepository implements ApiRepository {
  final ApiService _apiService;
  ApiRepositoryImpl(this._apiService);

  @override
  Future<DataState<LoginResponseModel>> login({required LoginRequestModel logInRequestModel}) {
    // TODO: implement signIn
    return getStateOf<LoginResponseModel>(
      request: () => _apiService.login(logInRequestModel: logInRequestModel),
    );
  }
}*/
