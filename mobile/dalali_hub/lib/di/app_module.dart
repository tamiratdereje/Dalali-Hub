import 'package:dio/dio.dart' hide LogInterceptor;
import 'package:dalali_hub/data/remote/client/auth_client.dart';
import 'package:dalali_hub/data/remote/client/user_client.dart';
import 'package:dalali_hub/domain/config/network_config.dart';
import 'package:dalali_hub/util/jwt_interceptor.dart';
import 'package:dalali_hub/util/log_interceptor.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@module
abstract class AppModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @singleton
  Dio dio(
    INetworkConfig config,
    LogInterceptor logInterceptor,
    JwtInterceptor jwtInterceptor,
  ) {
    return Dio()
      ..options = BaseOptions(
        baseUrl: config.baseUrl,
        headers: config.headers,
      )
      ..interceptors.addAll([
        jwtInterceptor,
        logInterceptor,
      ]);
  }

  @singleton
  AuthClient authClient(Dio dio) => AuthClient(dio);

  @singleton
  UserClient userClient(Dio dio) => UserClient(dio);
}
