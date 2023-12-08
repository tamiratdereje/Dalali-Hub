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
import 'package:dalali_hub/app/pages/auth/bloc/login/login_bloc.dart' as _i26;
import 'package:dalali_hub/app/pages/auth/bloc/logout/logout_bloc.dart' as _i27;
import 'package:dalali_hub/app/pages/auth/bloc/signup/signup_bloc.dart' as _i30;
import 'package:dalali_hub/app/pages/create_house/bloc/add_images/add_images_bloc.dart'
    as _i32;
import 'package:dalali_hub/app/pages/create_house/bloc/create_house/create_house_bloc.dart'
    as _i20;
import 'package:dalali_hub/app/pages/create_house/bloc/delete_house/delete_house_bloc.dart'
    as _i21;
import 'package:dalali_hub/app/pages/create_house/bloc/delete_image/delete_image_bloc.dart'
    as _i33;
import 'package:dalali_hub/app/pages/create_house/bloc/update_house/update_house_bloc.dart'
    as _i17;
import 'package:dalali_hub/app/pages/forget_password/bloc/request_bloc/request_otp_bloc.dart'
    as _i28;
import 'package:dalali_hub/app/pages/forget_password/bloc/reset_password/reset_password_bloc_bloc.dart'
    as _i29;
import 'package:dalali_hub/app/pages/forget_password/bloc/verify_otp/verify_otp_bloc.dart'
    as _i31;
import 'package:dalali_hub/data/local/pref/pref.dart' as _i9;
import 'package:dalali_hub/data/remote/client/auth_client.dart' as _i19;
import 'package:dalali_hub/data/remote/client/house_client.dart' as _i13;
import 'package:dalali_hub/data/remote/client/images_client.dart' as _i16;
import 'package:dalali_hub/data/remote/client/user_client.dart' as _i18;
import 'package:dalali_hub/data/remote/config/network_config.dart' as _i5;
import 'package:dalali_hub/data/repository/auth_repository.dart' as _i23;
import 'package:dalali_hub/data/repository/house_repository.dart' as _i15;
import 'package:dalali_hub/data/repository/images_repository.dart' as _i25;
import 'package:dalali_hub/di/app_module.dart' as _i34;
import 'package:dalali_hub/domain/config/network_config.dart' as _i4;
import 'package:dalali_hub/domain/repository/auth_repository.dart' as _i22;
import 'package:dalali_hub/domain/repository/house_repository.dart' as _i14;
import 'package:dalali_hub/domain/repository/images_repository.dart' as _i24;
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
    gh.singleton<_i13.HouseClient>(appModule.houseClient(gh<_i12.Dio>()));
    gh.lazySingleton<_i14.IHouseRepository>(
        () => _i15.HouseRepository(gh<_i13.HouseClient>()));
    gh.singleton<_i16.ImagesClient>(appModule.imageClient(gh<_i12.Dio>()));
    gh.factory<_i17.UpdateHouseBloc>(
        () => _i17.UpdateHouseBloc(gh<_i14.IHouseRepository>()));
    gh.singleton<_i18.UserClient>(appModule.userClient(gh<_i12.Dio>()));
    gh.singleton<_i19.AuthClient>(appModule.authClient(gh<_i12.Dio>()));
    gh.factory<_i20.CreateHouseBloc>(
        () => _i20.CreateHouseBloc(gh<_i14.IHouseRepository>()));
    gh.factory<_i21.DeleteHouseBloc>(
        () => _i21.DeleteHouseBloc(gh<_i14.IHouseRepository>()));
    gh.lazySingleton<_i22.IAuthRepository>(() => _i23.AuthRepository(
          gh<_i19.AuthClient>(),
          gh<_i9.SharedPreference>(),
        ));
    gh.lazySingleton<_i24.IImagesRepository>(
        () => _i25.ImagesRepository(gh<_i16.ImagesClient>()));
    gh.factory<_i26.LoginBloc>(() => _i26.LoginBloc(
          gh<_i22.IAuthRepository>(),
          gh<_i3.AuthCubit>(),
        ));
    gh.factory<_i27.LogoutBloc>(() => _i27.LogoutBloc(
          gh<_i3.AuthCubit>(),
          gh<_i22.IAuthRepository>(),
        ));
    gh.factory<_i28.RequestOtpBloc>(
        () => _i28.RequestOtpBloc(gh<_i22.IAuthRepository>()));
    gh.factory<_i29.ResetPasswordBloc>(
        () => _i29.ResetPasswordBloc(gh<_i22.IAuthRepository>()));
    gh.factory<_i30.SignupBloc>(
        () => _i30.SignupBloc(gh<_i22.IAuthRepository>()));
    gh.factory<_i31.VerifyOtpBloc>(
        () => _i31.VerifyOtpBloc(gh<_i22.IAuthRepository>()));
    gh.factory<_i32.AddImagesBloc>(
        () => _i32.AddImagesBloc(gh<_i24.IImagesRepository>()));
    gh.factory<_i33.DeleteImageBloc>(
        () => _i33.DeleteImageBloc(gh<_i24.IImagesRepository>()));
    return this;
  }
}

class _$AppModule extends _i34.AppModule {}
