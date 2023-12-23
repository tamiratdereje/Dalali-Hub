import 'dart:io';

import 'package:dalali_hub/constants/string_constants.dart';
import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:dalali_hub/data/remote/client/auth_client.dart';
import 'package:dalali_hub/data/remote/model/empty_response.dart';
import 'package:dalali_hub/data/remote/model/login_dto.dart';
import 'package:dalali_hub/data/remote/model/login_response_dto.dart';
import 'package:dalali_hub/data/remote/model/otp.dart';
import 'package:dalali_hub/data/remote/model/otp_verification_response_dto.dart';
import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/data/remote/model/reset_password.dart';
import 'package:dalali_hub/data/remote/model/signup_form_dto.dart';
import 'package:dalali_hub/data/remote/model/user_dto.dart';
import 'package:dalali_hub/data/remote/model/user_response_dto.dart';
import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/login.dart';
import 'package:dalali_hub/domain/entity/login_response.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/entity/reset_password.dart';
import 'package:dalali_hub/domain/entity/signup.dart';
import 'package:dalali_hub/domain/entity/user.dart';
import 'package:dalali_hub/domain/entity/user_response.dart';
import 'package:dalali_hub/domain/entity/verify_otp.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:dalali_hub/domain/type/types.dart';
import 'package:dalali_hub/util/app_exception.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final AuthClient _authClient;
  final SharedPreference _pref;

  AuthRepository(this._authClient, this._pref);

  @override
  Future<Resource<LoginResponse>> login(Login login) async {
    var response = await handleApiCall<LoginResponseDto>(
        _authClient.login(LoginDto.fromLogin(login)));
    if (response is Success) {
      var token = response.data!.token;
      await _pref.setString(tokenKey, token);
      return Success(response.data!.toLoginResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<Empty>> logout() async {
    try {
      await _pref.remove(tokenKey);
      return const Success(Empty());
    } catch (e) {
      return Error(AppException(e.toString()));
    }
  }

  @override
  Future<Resource<Empty>> register(SignupForm form) async {
    var response = await handleApiCall<EmptyResponse>(
        _authClient.register(SignupFormDto.fromEntity(form)));
    if (response is Success) {
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<Empty>> resendOtp(VerifyOtp otp) async {
    var response = await handleApiCall<EmptyResponse>(
        _authClient.requestOtp(Otp.fromEntity(otp)));
    if (response is Success) {
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<Empty>> verifyOtp(VerifyOtp otp) async {
    var response = await handleApiCall<OtpVerificationResponseDto>(
        _authClient.verifyOtp(Otp.fromEntity(otp)));
    if (response is Success) {
      if (otp.purpose == OtpPurpose.RESET_PASSWORD) {
        await _pref.setString(resetPasswordKey, response.data!.token!);
      }
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<Empty>> resetPassword(ResetPassword resetPassword) async {
    var response = await handleApiCall<EmptyResponse>(_authClient
        .resetPassword(ResetPasswordDto.fromEntity(resetPassword, _pref)));

    if (response is Success) {
      await _pref.remove(resetPasswordKey);
      return const Success(Empty());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<UserResponse>> getMyProfile() async {
    var response =
        await handleApiCall<UserResponseDto>(_authClient.getMyProfile());
    if (response is Success) {
      return Success(response.data!.toUserResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<UserResponse>> getOtherProfile(String id) async {
    var response =
        await handleApiCall<UserResponseDto>(_authClient.getOtherProfile(id));
    if (response is Success) {
      return Success(response.data!.toUserResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<UserResponse>> updateProfile(User user) async {
    var response = await handleApiCall<UserResponseDto>(
        _authClient.updateProfile(UserDto.fromEntity(user)));
    if (response is Success) {
      return Success(response.data!.toUserResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<List<PhotoResponse>>> updateProfilePicture(
      List<String> photos) async {
    var response = await handleApiCall<List<PhotoResponseDto>>(
        _authClient.updateProfilePicture(photos.map((e) => File(e)).toList()));
    if (response is Success) {
      return Success(response.data!.map((e) => e.toPhotoResponse()).toList());
    } else {
      return Error(response.error!);
    }
  }
}
