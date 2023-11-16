// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart' as _i17;
import 'package:dalali_hub/app/core/auth/cubit/auth_cubit.dart' as _i3;
import 'package:dalali_hub/app/navigation/navigator.dart' as _i9;
import 'package:dalali_hub/app/pages/auth/bloc/login/login_bloc.dart' as _i15;
import 'package:dalali_hub/app/pages/auth/bloc/logout/logout_bloc.dart' as _i16;
import 'package:dalali_hub/data/remote/client/auth_client.dart' as _i12;
import 'package:dalali_hub/data/remote/client/user_client.dart' as _i11;
import 'package:dalali_hub/data/remote/config/network_config.dart' as _i5;
import 'package:dalali_hub/data/repository/auth_repository.dart' as _i14;
import 'package:dalali_hub/di/app_module.dart' as _i18;
import 'package:dalali_hub/domain/config/network_config.dart' as _i4;
import 'package:dalali_hub/domain/repository/auth_repository.dart' as _i13;
import 'package:dalali_hub/util/jwt_interceptor.dart' as _i6;
import 'package:dalali_hub/util/log_interceptor.dart' as _i7;
import 'package:dio/dio.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

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
    gh.factory<_i3.AuthCubit>(() => _i3.AuthCubit());
    gh.factory<_i4.INetworkConfig>(() => _i5.NetworkConfig());
    gh.factory<_i6.JwtInterceptor>(() => _i6.JwtInterceptor());
    gh.singleton<_i7.LogInterceptor>(_i7.LogInterceptor());
    await gh.factoryAsync<_i8.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i9.AppRouter>(() => _i9.AppRouter(gh<_i3.AuthCubit>()));
    gh.singleton<_i10.Dio>(appModule.dio(
      gh<_i4.INetworkConfig>(),
      gh<_i7.LogInterceptor>(),
      gh<_i6.JwtInterceptor>(),
    ));
    gh.singleton<_i11.UserClient>(appModule.userClient(gh<_i10.Dio>()));
    gh.singleton<_i12.AuthClient>(appModule.authClient(gh<_i10.Dio>()));
    gh.lazySingleton<_i13.IAuthRepository>(
        () => _i14.AuthRepository(gh<_i12.AuthClient>()));
    gh.factory<_i15.LoginBloc>(() => _i15.LoginBloc(
          gh<_i13.IAuthRepository>(),
          gh<_i3.AuthCubit>(),
        ));
    gh.factory<_i16.LogoutBloc>(() => _i16.LogoutBloc(
          gh<_i3.AuthCubit>(),
          gh<_i13.IAuthRepository>(),
        ));
    gh.factory<_i17.AuthBloc>(() => _i17.AuthBloc(
          gh<_i3.AuthCubit>(),
          gh<_i13.IAuthRepository>(),
        ));
    return this;
  }
}

class _$AppModule extends _i18.AppModule {}
