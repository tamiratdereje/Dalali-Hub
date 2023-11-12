import 'package:dalali_hub/domain/entity/login.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IAuthRepository {
  Future<Resource<void>> login(Login login);
  Future<Resource<void>> register(String email, String password);
  Future<Resource<void>> logout();
  Future<Resource<void>> getProfile();
}
