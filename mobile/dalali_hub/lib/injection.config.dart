// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart' as _i55;
import 'package:dalali_hub/app/core/auth/cubit/auth_cubit.dart' as _i4;
import 'package:dalali_hub/app/navigation/navigator.dart' as _i10;
import 'package:dalali_hub/app/pages/auth/bloc/login/login_bloc.dart' as _i44;
import 'package:dalali_hub/app/pages/auth/bloc/logout/logout_bloc.dart' as _i45;
import 'package:dalali_hub/app/pages/auth/bloc/signup/signup_bloc.dart' as _i49;
import 'package:dalali_hub/app/pages/broker_home/bloc/get_my_stat/get_my_stat_bloc.dart'
    as _i34;
import 'package:dalali_hub/app/pages/broker_property_listing/bloc/my_listing/my_listing_bloc.dart'
    as _i25;
import 'package:dalali_hub/app/pages/chat/bloc/get_room/get_room_bloc.dart'
    as _i15;
import 'package:dalali_hub/app/pages/chat/bloc/get_rooms/get_rooms_bloc.dart'
    as _i13;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/add_images/add_images_bloc.dart'
    as _i54;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/create_realstate/create_realstate_bloc.dart'
    as _i56;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/delete_image/delete_image_bloc.dart'
    as _i58;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/delete_realstate/delete_realstate_bloc.dart'
    as _i59;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/update_realstate/update_realstate_bloc.dart'
    as _i51;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/create_vehicle/create_vehicle_bloc.dart'
    as _i57;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/delete_vehicle/delete_vehicle_bloc.dart'
    as _i60;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/update_vehicle/update_vehicle_bloc.dart'
    as _i52;
import 'package:dalali_hub/app/pages/customer_home/bloc/feeds/feeds_bloc.dart'
    as _i32;
import 'package:dalali_hub/app/pages/favorite/bloc/add_to_my_favorite/add_to_my_favorite_bloc.dart'
    as _i30;
import 'package:dalali_hub/app/pages/favorite/bloc/get_my_favorites/get_my_favorites_bloc.dart'
    as _i33;
import 'package:dalali_hub/app/pages/favorite/bloc/remove_from_my_favorite/remove_from_my_favorite_bloc.dart'
    as _i27;
import 'package:dalali_hub/app/pages/forget_password/bloc/request_bloc/request_otp_bloc.dart'
    as _i47;
import 'package:dalali_hub/app/pages/forget_password/bloc/reset_password/reset_password_bloc_bloc.dart'
    as _i48;
import 'package:dalali_hub/app/pages/forget_password/bloc/verify_otp/verify_otp_bloc.dart'
    as _i53;
import 'package:dalali_hub/app/pages/profile/bloc/profile/profile_bloc.dart'
    as _i46;
import 'package:dalali_hub/app/pages/profile/bloc/update_profile_photo/update_profile_photo_bloc.dart'
    as _i50;
import 'package:dalali_hub/app/pages/property_detail_for_customer/bloc/get_property/get_property_bloc.dart'
    as _i35;
import 'package:dalali_hub/app/pages/property_filter/bloc/filter_realstate/filter_realstate_bloc.dart'
    as _i61;
import 'package:dalali_hub/app/pages/property_filter/bloc/filter_vehicle/filter_vehicle_bloc.dart'
    as _i62;
import 'package:dalali_hub/data/local/pref/pref.dart' as _i14;
import 'package:dalali_hub/data/remote/client/auth_client.dart' as _i31;
import 'package:dalali_hub/data/remote/client/favorite_client.dart' as _i18;
import 'package:dalali_hub/data/remote/client/feed_client.dart' as _i19;
import 'package:dalali_hub/data/remote/client/images_client.dart' as _i24;
import 'package:dalali_hub/data/remote/client/realstate_client.dart' as _i26;
import 'package:dalali_hub/data/remote/client/user_client.dart' as _i28;
import 'package:dalali_hub/data/remote/client/vehicle_client.dart' as _i29;
import 'package:dalali_hub/data/remote/config/network_config.dart' as _i6;
import 'package:dalali_hub/data/repository/auth_repository.dart' as _i37;
import 'package:dalali_hub/data/repository/chat_repository.dart' as _i12;
import 'package:dalali_hub/data/repository/favorite_repository.dart' as _i21;
import 'package:dalali_hub/data/repository/feed_repository.dart' as _i23;
import 'package:dalali_hub/data/repository/images_repository.dart' as _i39;
import 'package:dalali_hub/data/repository/realstate_repository.dart' as _i41;
import 'package:dalali_hub/data/repository/vehicle_repository.dart' as _i43;
import 'package:dalali_hub/di/app_module.dart' as _i63;
import 'package:dalali_hub/domain/config/network_config.dart' as _i5;
import 'package:dalali_hub/domain/repository/auth_repository.dart' as _i36;
import 'package:dalali_hub/domain/repository/chat_repository.dart' as _i11;
import 'package:dalali_hub/domain/repository/favorite_repository.dart' as _i20;
import 'package:dalali_hub/domain/repository/feed_repository.dart' as _i22;
import 'package:dalali_hub/domain/repository/images_repository.dart' as _i38;
import 'package:dalali_hub/domain/repository/realstate_repository.dart' as _i40;
import 'package:dalali_hub/domain/repository/vehicle_repository.dart' as _i42;
import 'package:dalali_hub/util/jwt_interceptor.dart' as _i16;
import 'package:dalali_hub/util/log_interceptor.dart' as _i7;
import 'package:dalali_hub/util/realm.config.dart' as _i8;
import 'package:dio/dio.dart' as _i17;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:realm/realm.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i9;

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
    gh.factory<_i3.App>(() => appModule.app);
    gh.singleton<_i4.AuthCubit>(_i4.AuthCubit());
    gh.factory<_i5.INetworkConfig>(() => _i6.NetworkConfig());
    gh.singleton<_i7.LogInterceptor>(_i7.LogInterceptor());
    await gh.factoryAsync<_i8.RealmConfig>(
      () => appModule.realmConfig,
      preResolve: true,
    );
    await gh.factoryAsync<_i9.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.singleton<_i10.AppRouter>(_i10.AppRouter(gh<_i4.AuthCubit>()));
    gh.singleton<_i11.ChatRepository>(_i12.ChatRepositoryImpl(
      gh<_i8.RealmConfig>(),
      gh<_i3.App>(),
    ));
    gh.singleton<_i13.GetRoomsBloc>(
        _i13.GetRoomsBloc(gh<_i11.ChatRepository>()));
    gh.factory<_i14.SharedPreference>(
        () => _i14.SharedPreference(gh<_i9.SharedPreferences>()));
    gh.factory<_i15.GetRoomBloc>(() => _i15.GetRoomBloc(
          gh<_i14.SharedPreference>(),
          gh<_i11.ChatRepository>(),
        ));
    gh.factory<_i16.JwtInterceptor>(
        () => _i16.JwtInterceptor(pref: gh<_i14.SharedPreference>()));
    gh.singleton<_i17.Dio>(appModule.dio(
      gh<_i5.INetworkConfig>(),
      gh<_i7.LogInterceptor>(),
      gh<_i16.JwtInterceptor>(),
    ));
    gh.singleton<_i18.FavoriteClient>(appModule.favoriteClient(gh<_i17.Dio>()));
    gh.singleton<_i19.FeedClient>(appModule.feedClient(gh<_i17.Dio>()));
    gh.lazySingleton<_i20.IFavoriteRepository>(
        () => _i21.FavoriteRepository(gh<_i18.FavoriteClient>()));
    gh.lazySingleton<_i22.IFeedRepository>(
        () => _i23.FeedRepository(gh<_i19.FeedClient>()));
    gh.singleton<_i24.ImagesClient>(appModule.imageClient(gh<_i17.Dio>()));
    gh.factory<_i25.MyListingBloc>(
        () => _i25.MyListingBloc(gh<_i22.IFeedRepository>()));
    gh.singleton<_i26.RealstateClient>(
        appModule.realstateClient(gh<_i17.Dio>()));
    gh.factory<_i27.RemoveFromMyFavoriteBloc>(
        () => _i27.RemoveFromMyFavoriteBloc(gh<_i20.IFavoriteRepository>()));
    gh.singleton<_i28.UserClient>(appModule.userClient(gh<_i17.Dio>()));
    gh.singleton<_i29.VehicleClient>(appModule.vehicleClient(gh<_i17.Dio>()));
    gh.factory<_i30.AddToMyFavoriteBloc>(
        () => _i30.AddToMyFavoriteBloc(gh<_i20.IFavoriteRepository>()));
    gh.singleton<_i31.AuthClient>(appModule.authClient(gh<_i17.Dio>()));
    gh.factory<_i32.FeedsBloc>(
        () => _i32.FeedsBloc(gh<_i22.IFeedRepository>()));
    gh.factory<_i33.GetMyFavoritesBloc>(
        () => _i33.GetMyFavoritesBloc(gh<_i20.IFavoriteRepository>()));
    gh.factory<_i34.GetMyStatBloc>(
        () => _i34.GetMyStatBloc(gh<_i22.IFeedRepository>()));
    gh.factory<_i35.GetPropertyBloc>(() => _i35.GetPropertyBloc(
          gh<_i22.IFeedRepository>(),
          gh<_i20.IFavoriteRepository>(),
        ));
    gh.lazySingleton<_i36.IAuthRepository>(() => _i37.AuthRepository(
          gh<_i31.AuthClient>(),
          gh<_i14.SharedPreference>(),
          gh<_i3.App>(),
        ));
    gh.lazySingleton<_i38.IImagesRepository>(
        () => _i39.ImagesRepository(gh<_i24.ImagesClient>()));
    gh.lazySingleton<_i40.IRealstateRepository>(
        () => _i41.RealstateRepository(gh<_i26.RealstateClient>()));
    gh.lazySingleton<_i42.IVehicleRepository>(
        () => _i43.VehicleRepository(gh<_i29.VehicleClient>()));
    gh.factory<_i44.LoginBloc>(() => _i44.LoginBloc(
          gh<_i36.IAuthRepository>(),
          gh<_i4.AuthCubit>(),
        ));
    gh.factory<_i45.LogoutBloc>(() => _i45.LogoutBloc(
          gh<_i4.AuthCubit>(),
          gh<_i36.IAuthRepository>(),
        ));
    gh.factory<_i46.ProfileBloc>(
        () => _i46.ProfileBloc(gh<_i36.IAuthRepository>()));
    gh.factory<_i47.RequestOtpBloc>(
        () => _i47.RequestOtpBloc(gh<_i36.IAuthRepository>()));
    gh.factory<_i48.ResetPasswordBloc>(
        () => _i48.ResetPasswordBloc(gh<_i36.IAuthRepository>()));
    gh.factory<_i49.SignupBloc>(
        () => _i49.SignupBloc(gh<_i36.IAuthRepository>()));
    gh.factory<_i50.UpdateProfilePhotoBloc>(
        () => _i50.UpdateProfilePhotoBloc(gh<_i36.IAuthRepository>()));
    gh.factory<_i51.UpdateRealstateBloc>(
        () => _i51.UpdateRealstateBloc(gh<_i40.IRealstateRepository>()));
    gh.factory<_i52.UpdateVehicleBloc>(
        () => _i52.UpdateVehicleBloc(gh<_i42.IVehicleRepository>()));
    gh.factory<_i53.VerifyOtpBloc>(
        () => _i53.VerifyOtpBloc(gh<_i36.IAuthRepository>()));
    gh.factory<_i54.AddImagesBloc>(
        () => _i54.AddImagesBloc(gh<_i38.IImagesRepository>()));
    gh.factory<_i55.AuthBloc>(() => _i55.AuthBloc(
          gh<_i4.AuthCubit>(),
          gh<_i14.SharedPreference>(),
          gh<_i36.IAuthRepository>(),
        ));
    gh.factory<_i56.CreateRealstateBloc>(
        () => _i56.CreateRealstateBloc(gh<_i40.IRealstateRepository>()));
    gh.factory<_i57.CreateVehicleBloc>(
        () => _i57.CreateVehicleBloc(gh<_i42.IVehicleRepository>()));
    gh.factory<_i58.DeleteImageBloc>(
        () => _i58.DeleteImageBloc(gh<_i38.IImagesRepository>()));
    gh.factory<_i59.DeleteRealstateBloc>(
        () => _i59.DeleteRealstateBloc(gh<_i40.IRealstateRepository>()));
    gh.factory<_i60.DeleteVehicleBloc>(
        () => _i60.DeleteVehicleBloc(gh<_i42.IVehicleRepository>()));
    gh.factory<_i61.FilterRealstateBloc>(
        () => _i61.FilterRealstateBloc(gh<_i40.IRealstateRepository>()));
    gh.factory<_i62.FilterVehicleBloc>(
        () => _i62.FilterVehicleBloc(gh<_i42.IVehicleRepository>()));
    return this;
  }
}

class _$AppModule extends _i63.AppModule {}
