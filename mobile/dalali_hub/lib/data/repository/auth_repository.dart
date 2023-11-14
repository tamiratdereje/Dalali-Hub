import 'package:dalali_hub/constants/string_constants.dart';
import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:dalali_hub/data/remote/client/auth_client.dart';
import 'package:dalali_hub/data/remote/model/login_dto.dart';
import 'package:dalali_hub/data/remote/model/login_response_dto.dart';
import 'package:dalali_hub/domain/entity/login.dart';
import 'package:dalali_hub/domain/entity/login_response.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  final AuthClient _authClient;

  AuthRepository(this._authClient);

  @override
  Future<Resource<void>> getProfile() async {
    // TODO: implement getProfile
    throw UnimplementedError();
  }

  @override
  Future<Resource<LoginResponse>> login(Login login) async {
    var response =
        await handleApiCall(_authClient.login(LoginDto.fromLogin(login)));
    if (response is Success) {
      SharedPreference.setString(tokenKey, response.data!.token);
      return Success(response.data!.toLoginResponse());
    } else {
      return Error(response.error!);
    }
  }

  @override
  Future<Resource<void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Resource<void>> register(String email, String password) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
