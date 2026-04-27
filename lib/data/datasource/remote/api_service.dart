/*

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../utils/constants/api_environment.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiEnvironment.baseUrl + ApiEnvironment.apiPrefix, parser: Parser.JsonSerializable)
abstract class ApiService {factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  @POST(ApiEnvironment.login)
  Future<HttpResponse<LoginResponseModel>> login({
    @Body() required LoginRequestModel logInRequestModel,
  });
}
*/
