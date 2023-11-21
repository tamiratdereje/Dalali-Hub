import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/login.dart';
import 'package:dalali_hub/domain/entity/login_response.dart';
import 'package:dalali_hub/domain/entity/reset_password.dart';
import 'package:dalali_hub/domain/entity/signup.dart';
import 'package:dalali_hub/domain/entity/verify_otp.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IAuthRepository {
  Future<Resource<LoginResponse>> login(Login login);
  Future<Resource<Empty>> register(SignupForm form);
  Future<Resource<void>> logout();
  Future<Resource<void>> getProfile();
  Future<Resource<Empty>> verifyOtp(VerifyOtp otp);
  Future<Resource<Empty>> resendOtp(VerifyOtp otp);
  Future<Resource<Empty>> resetPassword(ResetPassword resetPassword);
}
