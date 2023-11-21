import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/data/remote/model/otp.dart';
import 'package:dalali_hub/data/remote/model/otp_verification_response_dto.dart';
import 'package:dalali_hub/data/remote/model/signup_form_dto.dart';
import 'package:dio/dio.dart';
import 'package:dalali_hub/data/remote/model/jsend_response.dart';
import 'package:dalali_hub/data/remote/model/login_dto.dart';
import 'package:dalali_hub/data/remote/model/login_response_dto.dart';
import 'package:retrofit/retrofit.dart';

part 'auth_client.g.dart';

@RestApi(baseUrl: 'api/v1/')
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @POST('auth/login')
  Future<HttpResponse<JSendResponse<LoginResponseDto>>> login(
      @Body() LoginDto loginDto);

  @POST('auth/signup')
  Future<HttpResponse<JSendResponse<EmptyResponse>>> register(
      @Body() SignupFormDto signupFormDto);

  @POST('auth/verify-otp')
  Future<HttpResponse<JSendResponse<OtpVerificationResponseDto>>> verifyOtp(
      @Body() Otp otp);

  @POST('auth/request-otp')
  Future<HttpResponse<JSendResponse<EmptyResponse>>> requestOtp(
      @Body() Otp otpRequest);
}
