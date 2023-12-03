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
import 'package:dalali_hub/app/pages/auth/bloc/login/login_bloc.dart' as _i21;
import 'package:dalali_hub/app/pages/auth/bloc/logout/logout_bloc.dart' as _i22;
import 'package:dalali_hub/app/pages/auth/bloc/signup/signup_bloc.dart' as _i25;
import 'package:dalali_hub/app/pages/create_house/bloc/create_house/create_house_bloc.dart'
    as _i18;
import 'package:dalali_hub/app/pages/forget_password/bloc/request_bloc/request_otp_bloc.dart'
    as _i23;
import 'package:dalali_hub/app/pages/forget_password/bloc/reset_password/reset_password_bloc_bloc.dart'
    as _i24;
import 'package:dalali_hub/app/pages/forget_password/bloc/verify_otp/verify_otp_bloc.dart'
    as _i26;
import 'package:dalali_hub/data/local/pref/pref.dart' as _i9;
import 'package:dalali_hub/data/remote/client/auth_client.dart' as _i17;
import 'package:dalali_hub/data/remote/client/house_client.dart' as _i13;
import 'package:dalali_hub/data/remote/client/user_client.dart' as _i16;
import 'package:dalali_hub/data/remote/config/network_config.dart' as _i5;
import 'package:dalali_hub/data/repository/auth_repository.dart' as _i20;
import 'package:dalali_hub/data/repository/house_repository.dart' as _i15;
import 'package:dalali_hub/di/app_module.dart' as _i27;
import 'package:dalali_hub/domain/config/network_config.dart' as _i4;
import 'package:dalali_hub/domain/repository/auth_repository.dart' as _i19;
import 'package:dalali_hub/domain/repository/house_repository.dart' as _i14;
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
    gh.singleton<_i16.UserClient>(appModule.userClient(gh<_i12.Dio>()));
    gh.singleton<_i17.AuthClient>(appModule.authClient(gh<_i12.Dio>()));
    gh.factory<_i18.CreateHouseBloc>(
        () => _i18.CreateHouseBloc(gh<_i14.IHouseRepository>()));
    gh.lazySingleton<_i19.IAuthRepository>(() => _i20.AuthRepository(
          gh<_i17.AuthClient>(),
          gh<_i9.SharedPreference>(),
        ));
    gh.factory<_i21.LoginBloc>(() => _i21.LoginBloc(
          gh<_i19.IAuthRepository>(),
          gh<_i3.AuthCubit>(),
        ));
    gh.factory<_i22.LogoutBloc>(() => _i22.LogoutBloc(
          gh<_i3.AuthCubit>(),
          gh<_i19.IAuthRepository>(),
        ));
    gh.factory<_i23.RequestOtpBloc>(
        () => _i23.RequestOtpBloc(gh<_i19.IAuthRepository>()));
    gh.factory<_i24.ResetPasswordBloc>(
        () => _i24.ResetPasswordBloc(gh<_i19.IAuthRepository>()));
    gh.factory<_i25.SignupBloc>(
        () => _i25.SignupBloc(gh<_i19.IAuthRepository>()));
    gh.factory<_i26.VerifyOtpBloc>(
        () => _i26.VerifyOtpBloc(gh<_i19.IAuthRepository>()));
    return this;
  }
}

class _$AppModule extends _i27.AppModule {}
