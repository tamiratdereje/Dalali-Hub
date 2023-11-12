import 'package:dio/dio.dart';
import 'package:dalali_hub/constants/string_constants.dart';
import 'package:dalali_hub/data/remote/model/jsend_response.dart';
import 'package:dalali_hub/data/remote/model/login_dto.dart';
import 'package:dalali_hub/data/remote/model/login_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_client.g.dart';

@RestApi(baseUrl: baseUrl)
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @GET('v4/articles/')
  Future<HttpResponse<JSendResponse<LoginResponse>>> login(
      @Body() LoginDto loginDto);
}
