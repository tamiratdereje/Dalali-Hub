// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart' as _i10;
import 'package:dalali_hub/app/core/auth/cubit/auth_cubit.dart' as _i3;
import 'package:dalali_hub/app/navigation/navigator.dart' as _i8;
import 'package:dalali_hub/app/pages/auth/bloc/login/login_bloc.dart' as _i36;
import 'package:dalali_hub/app/pages/auth/bloc/logout/logout_bloc.dart' as _i37;
import 'package:dalali_hub/app/pages/auth/bloc/signup/signup_bloc.dart' as _i40;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/add_images/add_images_bloc.dart'
    as _i44;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/create_realstate/create_realstate_bloc.dart'
    as _i45;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/delete_image/delete_image_bloc.dart'
    as _i47;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/delete_realstate/delete_realstate_bloc.dart'
    as _i48;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/update_realstate/update_realstate_bloc.dart'
    as _i41;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/create_vehicle/create_vehicle_bloc.dart'
    as _i46;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/delete_vehicle/delete_vehicle_bloc.dart'
    as _i49;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/update_vehicle/update_vehicle_bloc.dart'
    as _i42;
import 'package:dalali_hub/app/pages/customer_home/bloc/feeds/feeds_bloc.dart'
    as _i26;
import 'package:dalali_hub/app/pages/favorite/bloc/add_to_my_favorite/add_to_my_favorite_bloc.dart'
    as _i24;
import 'package:dalali_hub/app/pages/favorite/bloc/get_my_favorites/get_my_favorites_bloc.dart'
    as _i27;
import 'package:dalali_hub/app/pages/favorite/bloc/remove_from_my_favorite/remove_from_my_favorite_bloc.dart'
    as _i21;
import 'package:dalali_hub/app/pages/forget_password/bloc/request_bloc/request_otp_bloc.dart'
    as _i38;
import 'package:dalali_hub/app/pages/forget_password/bloc/reset_password/reset_password_bloc_bloc.dart'
    as _i39;
import 'package:dalali_hub/app/pages/forget_password/bloc/verify_otp/verify_otp_bloc.dart'
    as _i43;
import 'package:dalali_hub/app/pages/property_filter/bloc/filter_realstate/filter_realstate_bloc.dart'
    as _i50;
import 'package:dalali_hub/app/pages/property_filter/bloc/filter_vehicle/filter_vehicle_bloc.dart'
    as _i51;
import 'package:dalali_hub/data/local/pref/pref.dart' as _i9;
import 'package:dalali_hub/data/remote/client/auth_client.dart' as _i25;
import 'package:dalali_hub/data/remote/client/favorite_client.dart' as _i13;
import 'package:dalali_hub/data/remote/client/feed_client.dart' as _i14;
import 'package:dalali_hub/data/remote/client/images_client.dart' as _i19;
import 'package:dalali_hub/data/remote/client/realstate_client.dart' as _i20;
import 'package:dalali_hub/data/remote/client/user_client.dart' as _i22;
import 'package:dalali_hub/data/remote/client/vehicle_client.dart' as _i23;
import 'package:dalali_hub/data/remote/config/network_config.dart' as _i5;
import 'package:dalali_hub/data/repository/auth_repository.dart' as _i29;
import 'package:dalali_hub/data/repository/favorite_repository.dart' as _i16;
import 'package:dalali_hub/data/repository/feed_repository.dart' as _i18;
import 'package:dalali_hub/data/repository/images_repository.dart' as _i31;
import 'package:dalali_hub/data/repository/realstate_repository.dart' as _i33;
import 'package:dalali_hub/data/repository/vehicle_repository.dart' as _i35;
import 'package:dalali_hub/di/app_module.dart' as _i52;
import 'package:dalali_hub/domain/config/network_config.dart' as _i4;
import 'package:dalali_hub/domain/repository/auth_repository.dart' as _i28;
import 'package:dalali_hub/domain/repository/favorite_repository.dart' as _i15;
import 'package:dalali_hub/domain/repository/feed_repository.dart' as _i17;
import 'package:dalali_hub/domain/repository/images_repository.dart' as _i30;
import 'package:dalali_hub/domain/repository/realstate_repository.dart' as _i32;
import 'package:dalali_hub/domain/repository/vehicle_repository.dart' as _i34;
import 'package:dalali_hub/util/jwt_interceptor.dart' as _i11;
import 'package:dalali_hub/util/log_interceptor.dart' as _i6;
import 'package:dio/dio.dart' as _i12;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.singleton<_i3.AuthCubit>(_i3.AuthCubit());
    gh.factory<_i4.INetworkConfig>(() => _i5.NetworkConfig());
    gh.singleton<_i6.LogInterceptor>(_i6.LogInterceptor());
    await gh.factoryAsync<_i7.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i8.AppRouter>(() => _i8.AppRouter(gh<_i3.AuthCubit>()));
    gh.factory<_i9.SharedPreference>(
        () => _i9.SharedPreference(gh<_i7.SharedPreferences>()));
    gh.factory<_i10.AuthBloc>(() => _i10.AuthBloc(
          gh<_i3.AuthCubit>(),
          gh<_i9.SharedPreference>(),
        ));
    gh.factory<_i11.JwtInterceptor>(
        () => _i11.JwtInterceptor(pref: gh<_i9.SharedPreference>()));
    gh.singleton<_i12.Dio>(appModule.dio(
      gh<_i4.INetworkConfig>(),
      gh<_i6.LogInterceptor>(),
      gh<_i11.JwtInterceptor>(),
    ));
    gh.singleton<_i13.FavoriteClient>(appModule.favoriteClient(gh<_i12.Dio>()));
    gh.singleton<_i14.FeedClient>(appModule.feedClient(gh<_i12.Dio>()));
    gh.lazySingleton<_i15.IFavoriteRepository>(
        () => _i16.FavoriteRepository(gh<_i13.FavoriteClient>()));
    gh.lazySingleton<_i17.IFeedRepository>(
        () => _i18.FeedRepository(gh<_i14.FeedClient>()));
    gh.singleton<_i19.ImagesClient>(appModule.imageClient(gh<_i12.Dio>()));
    gh.singleton<_i20.RealstateClient>(
        appModule.realstateClient(gh<_i12.Dio>()));
    gh.factory<_i21.RemoveFromMyFavoriteBloc>(
        () => _i21.RemoveFromMyFavoriteBloc(gh<_i15.IFavoriteRepository>()));
    gh.singleton<_i22.UserClient>(appModule.userClient(gh<_i12.Dio>()));
    gh.singleton<_i23.VehicleClient>(appModule.vehicleClient(gh<_i12.Dio>()));
    gh.factory<_i24.AddToMyFavoriteBloc>(
        () => _i24.AddToMyFavoriteBloc(gh<_i15.IFavoriteRepository>()));
    gh.singleton<_i25.AuthClient>(appModule.authClient(gh<_i12.Dio>()));
    gh.factory<_i26.FeedsBloc>(
        () => _i26.FeedsBloc(gh<_i17.IFeedRepository>()));
    gh.factory<_i27.GetMyFavoritesBloc>(
        () => _i27.GetMyFavoritesBloc(gh<_i15.IFavoriteRepository>()));
    gh.lazySingleton<_i28.IAuthRepository>(() => _i29.AuthRepository(
          gh<_i25.AuthClient>(),
          gh<_i9.SharedPreference>(),
        ));
    gh.lazySingleton<_i30.IImagesRepository>(
        () => _i31.ImagesRepository(gh<_i19.ImagesClient>()));
    gh.lazySingleton<_i32.IRealstateRepository>(
        () => _i33.RealstateRepository(gh<_i20.RealstateClient>()));
    gh.lazySingleton<_i34.IVehicleRepository>(
        () => _i35.VehicleRepository(gh<_i23.VehicleClient>()));
    gh.factory<_i36.LoginBloc>(() => _i36.LoginBloc(
          gh<_i28.IAuthRepository>(),
          gh<_i3.AuthCubit>(),
        ));
    gh.factory<_i37.LogoutBloc>(() => _i37.LogoutBloc(
          gh<_i3.AuthCubit>(),
          gh<_i28.IAuthRepository>(),
        ));
    gh.factory<_i38.RequestOtpBloc>(
        () => _i38.RequestOtpBloc(gh<_i28.IAuthRepository>()));
    gh.factory<_i39.ResetPasswordBloc>(
        () => _i39.ResetPasswordBloc(gh<_i28.IAuthRepository>()));
    gh.factory<_i40.SignupBloc>(
        () => _i40.SignupBloc(gh<_i28.IAuthRepository>()));
    gh.factory<_i41.UpdateRealstateBloc>(
        () => _i41.UpdateRealstateBloc(gh<_i32.IRealstateRepository>()));
    gh.factory<_i42.UpdateVehicleBloc>(
        () => _i42.UpdateVehicleBloc(gh<_i34.IVehicleRepository>()));
    gh.factory<_i43.VerifyOtpBloc>(
        () => _i43.VerifyOtpBloc(gh<_i28.IAuthRepository>()));
    gh.factory<_i44.AddImagesBloc>(
        () => _i44.AddImagesBloc(gh<_i30.IImagesRepository>()));
    gh.factory<_i45.CreateRealstateBloc>(
        () => _i45.CreateRealstateBloc(gh<_i32.IRealstateRepository>()));
    gh.factory<_i46.CreateVehicleBloc>(
        () => _i46.CreateVehicleBloc(gh<_i34.IVehicleRepository>()));
    gh.factory<_i47.DeleteImageBloc>(
        () => _i47.DeleteImageBloc(gh<_i30.IImagesRepository>()));
    gh.factory<_i48.DeleteRealstateBloc>(
        () => _i48.DeleteRealstateBloc(gh<_i32.IRealstateRepository>()));
    gh.factory<_i49.DeleteVehicleBloc>(
        () => _i49.DeleteVehicleBloc(gh<_i34.IVehicleRepository>()));
    gh.factory<_i50.FilterRealstateBloc>(
        () => _i50.FilterRealstateBloc(gh<_i32.IRealstateRepository>()));
    gh.factory<_i51.FilterVehicleBloc>(
        () => _i51.FilterVehicleBloc(gh<_i34.IVehicleRepository>()));
    return this;
  }
}

class _$AppModule extends _i52.AppModule {}
