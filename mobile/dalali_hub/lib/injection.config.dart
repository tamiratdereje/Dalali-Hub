// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart' as _i22;
import 'package:dalali_hub/app/core/auth/cubit/auth_cubit.dart' as _i3;
import 'package:dalali_hub/app/navigation/navigator.dart' as _i16;
import 'package:dalali_hub/app/pages/auth/bloc/login/login_bloc.dart' as _i42;
import 'package:dalali_hub/app/pages/auth/bloc/logout/logout_bloc.dart' as _i43;
import 'package:dalali_hub/app/pages/auth/bloc/signup/signup_bloc.dart' as _i46;
import 'package:dalali_hub/app/pages/create_house/bloc/add_images/add_images_bloc.dart'
    as _i48;
import 'package:dalali_hub/app/pages/create_house/bloc/create_house/create_house_bloc.dart'
    as _i35;
import 'package:dalali_hub/app/pages/create_house/bloc/delete_house/delete_house_bloc.dart'
    as _i36;
import 'package:dalali_hub/app/pages/create_house/bloc/delete_image/delete_image_bloc.dart'
    as _i50;
import 'package:dalali_hub/app/pages/create_house/bloc/update_house/update_house_bloc.dart'
    as _i32;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/add_images/add_images_bloc.dart'
    as _i49;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/create_realstate/create_realstate_bloc.dart'
    as _i17;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/delete_image/delete_image_bloc.dart'
    as _i51;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/delete_realstate/delete_realstate_bloc.dart'
    as _i19;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/update_realstate/update_realstate_bloc.dart'
    as _i14;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/create_vehicle/create_vehicle_bloc.dart'
    as _i18;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/delete_vehicle/delete_vehicle_bloc.dart'
    as _i20;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/update_vehicle/update_vehicle_bloc.dart'
    as _i15;
import 'package:dalali_hub/app/pages/customer_home/bloc/feeds/feeds_bloc.dart'
    as _i37;
import 'package:dalali_hub/app/pages/forget_password/bloc/request_bloc/request_otp_bloc.dart'
    as _i44;
import 'package:dalali_hub/app/pages/forget_password/bloc/reset_password/reset_password_bloc_bloc.dart'
    as _i45;
import 'package:dalali_hub/app/pages/forget_password/bloc/verify_otp/verify_otp_bloc.dart'
    as _i47;
import 'package:dalali_hub/data/local/pref/pref.dart' as _i21;
import 'package:dalali_hub/data/remote/client/auth_client.dart' as _i34;
import 'package:dalali_hub/data/remote/client/feed_client.dart' as _i25;
import 'package:dalali_hub/data/remote/client/house_client.dart' as _i26;
import 'package:dalali_hub/data/remote/client/images_client.dart' as _i31;
import 'package:dalali_hub/data/remote/client/realstate_client.dart' as _i8;
import 'package:dalali_hub/data/remote/client/user_client.dart' as _i33;
import 'package:dalali_hub/data/remote/client/vehicle_client.dart' as _i11;
import 'package:dalali_hub/data/remote/config/network_config.dart' as _i5;
import 'package:dalali_hub/data/repository/auth_repository.dart' as _i39;
import 'package:dalali_hub/data/repository/feed_repository.dart' as _i28;
import 'package:dalali_hub/data/repository/house_repository.dart' as _i30;
import 'package:dalali_hub/data/repository/images_repository.dart' as _i41;
import 'package:dalali_hub/data/repository/realstate_repository.dart' as _i7;
import 'package:dalali_hub/data/repository/vehicle_repository.dart' as _i10;
import 'package:dalali_hub/di/app_module.dart' as _i52;
import 'package:dalali_hub/domain/config/network_config.dart' as _i4;
import 'package:dalali_hub/domain/repository/auth_repository.dart' as _i38;
import 'package:dalali_hub/domain/repository/feed_repository.dart' as _i27;
import 'package:dalali_hub/domain/repository/house_repository.dart' as _i29;
import 'package:dalali_hub/domain/repository/images_repository.dart' as _i40;
import 'package:dalali_hub/domain/repository/realstate_repository.dart' as _i6;
import 'package:dalali_hub/domain/repository/vehicle_repository.dart' as _i9;
import 'package:dalali_hub/util/jwt_interceptor.dart' as _i23;
import 'package:dalali_hub/util/log_interceptor.dart' as _i12;
import 'package:dio/dio.dart' as _i24;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i13;

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
    gh.lazySingleton<_i6.IRealstateRepository>(
        () => _i7.RealstateRepository(gh<_i8.RealstateClient>()));
    gh.lazySingleton<_i9.IVehicleRepository>(
        () => _i10.VehicleRepository(gh<_i11.VehicleClient>()));
    gh.singleton<_i12.LogInterceptor>(_i12.LogInterceptor());
    await gh.factoryAsync<_i13.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i14.UpdateRealstateBloc>(
        () => _i14.UpdateRealstateBloc(gh<_i6.IRealstateRepository>()));
    gh.factory<_i15.UpdateVehicleBloc>(
        () => _i15.UpdateVehicleBloc(gh<_i9.IVehicleRepository>()));
    gh.factory<_i16.AppRouter>(() => _i16.AppRouter(gh<_i3.AuthCubit>()));
    gh.factory<_i17.CreateRealstateBloc>(
        () => _i17.CreateRealstateBloc(gh<_i6.IRealstateRepository>()));
    gh.factory<_i18.CreateVehicleBloc>(
        () => _i18.CreateVehicleBloc(gh<_i9.IVehicleRepository>()));
    gh.factory<_i19.DeleteRealstateBloc>(
        () => _i19.DeleteRealstateBloc(gh<_i6.IRealstateRepository>()));
    gh.factory<_i20.DeleteVehicleBloc>(
        () => _i20.DeleteVehicleBloc(gh<_i9.IVehicleRepository>()));
    gh.factory<_i21.SharedPreference>(
        () => _i21.SharedPreference(gh<_i13.SharedPreferences>()));
    gh.factory<_i22.AuthBloc>(() => _i22.AuthBloc(
          gh<_i3.AuthCubit>(),
          gh<_i21.SharedPreference>(),
        ));
    gh.factory<_i23.JwtInterceptor>(
        () => _i23.JwtInterceptor(pref: gh<_i21.SharedPreference>()));
    gh.singleton<_i24.Dio>(appModule.dio(
      gh<_i4.INetworkConfig>(),
      gh<_i12.LogInterceptor>(),
      gh<_i23.JwtInterceptor>(),
    ));
    gh.singleton<_i25.FeedClient>(appModule.feedClient(gh<_i24.Dio>()));
    gh.singleton<_i26.HouseClient>(appModule.houseClient(gh<_i24.Dio>()));
    gh.lazySingleton<_i27.IFeedRepository>(
        () => _i28.FeedRepository(gh<_i25.FeedClient>()));
    gh.lazySingleton<_i29.IHouseRepository>(
        () => _i30.HouseRepository(gh<_i26.HouseClient>()));
    gh.singleton<_i31.ImagesClient>(appModule.imageClient(gh<_i24.Dio>()));
    gh.factory<_i32.UpdateHouseBloc>(
        () => _i32.UpdateHouseBloc(gh<_i29.IHouseRepository>()));
    gh.singleton<_i33.UserClient>(appModule.userClient(gh<_i24.Dio>()));
    gh.singleton<_i34.AuthClient>(appModule.authClient(gh<_i24.Dio>()));
    gh.factory<_i35.CreateHouseBloc>(
        () => _i35.CreateHouseBloc(gh<_i29.IHouseRepository>()));
    gh.factory<_i36.DeleteHouseBloc>(
        () => _i36.DeleteHouseBloc(gh<_i29.IHouseRepository>()));
    gh.factory<_i37.FeedsBloc>(
        () => _i37.FeedsBloc(gh<_i27.IFeedRepository>()));
    gh.lazySingleton<_i38.IAuthRepository>(() => _i39.AuthRepository(
          gh<_i34.AuthClient>(),
          gh<_i21.SharedPreference>(),
        ));
    gh.lazySingleton<_i40.IImagesRepository>(
        () => _i41.ImagesRepository(gh<_i31.ImagesClient>()));
    gh.factory<_i42.LoginBloc>(() => _i42.LoginBloc(
          gh<_i38.IAuthRepository>(),
          gh<_i3.AuthCubit>(),
        ));
    gh.factory<_i43.LogoutBloc>(() => _i43.LogoutBloc(
          gh<_i3.AuthCubit>(),
          gh<_i38.IAuthRepository>(),
        ));
    gh.factory<_i44.RequestOtpBloc>(
        () => _i44.RequestOtpBloc(gh<_i38.IAuthRepository>()));
    gh.factory<_i45.ResetPasswordBloc>(
        () => _i45.ResetPasswordBloc(gh<_i38.IAuthRepository>()));
    gh.factory<_i46.SignupBloc>(
        () => _i46.SignupBloc(gh<_i38.IAuthRepository>()));
    gh.factory<_i47.VerifyOtpBloc>(
        () => _i47.VerifyOtpBloc(gh<_i38.IAuthRepository>()));
    gh.factory<_i48.AddImagesBloc>(
        () => _i48.AddImagesBloc(gh<_i40.IImagesRepository>()));
    gh.factory<_i49.AddImagesBloc>(
        () => _i49.AddImagesBloc(gh<_i40.IImagesRepository>()));
    gh.factory<_i50.DeleteImageBloc>(
        () => _i50.DeleteImageBloc(gh<_i40.IImagesRepository>()));
    gh.factory<_i51.DeleteImageBloc>(
        () => _i51.DeleteImageBloc(gh<_i40.IImagesRepository>()));
    return this;
  }
}

class _$AppModule extends _i52.AppModule {}
