import 'package:dalali_hub/data/remote/client/favorite_client.dart';
import 'package:dalali_hub/data/remote/client/feed_client.dart';
import 'package:dalali_hub/data/remote/client/images_client.dart';
import 'package:dalali_hub/data/remote/client/realstate_client.dart';
import 'package:dalali_hub/data/remote/client/vehicle_client.dart';
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
        headers: config.headers,
        baseUrl: config.baseUrl,
        sendTimeout: config.timeout,
        connectTimeout: config.timeout,
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

  @singleton
  ImagesClient imageClient(Dio dio) => ImagesClient(dio);

  @singleton
  FeedClient feedClient(Dio dio) => FeedClient(dio);

  @singleton
  RealstateClient realstateClient(Dio dio) => RealstateClient(dio);

  @singleton
  VehicleClient vehicleClient(Dio dio) => VehicleClient(dio);

  @singleton
  FavoriteClient favoriteClient(Dio dio) => FavoriteClient(dio);
}
