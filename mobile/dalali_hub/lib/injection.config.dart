// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart' as _i49;
import 'package:dalali_hub/app/core/auth/cubit/auth_cubit.dart' as _i5;
import 'package:dalali_hub/app/navigation/navigator.dart' as _i66;
import 'package:dalali_hub/app/pages/auth/bloc/login/login_bloc.dart' as _i62;
import 'package:dalali_hub/app/pages/auth/bloc/logout/logout_bloc.dart' as _i63;
import 'package:dalali_hub/app/pages/auth/bloc/signup/signup_bloc.dart' as _i43;
import 'package:dalali_hub/app/pages/broker_home/bloc/get_my_stat/get_my_stat_bloc.dart'
    as _i30;
import 'package:dalali_hub/app/pages/broker_property_listing/bloc/my_listing/my_listing_bloc.dart'
    as _i21;
import 'package:dalali_hub/app/pages/chat/bloc/get_messages/get_messages_bloc.dart'
    as _i59;
import 'package:dalali_hub/app/pages/chat/bloc/get_room/get_room_bloc.dart'
    as _i60;
import 'package:dalali_hub/app/pages/chat/bloc/get_rooms/get_rooms_bloc.dart'
    as _i61;
import 'package:dalali_hub/app/pages/chat/bloc/send_message/send_message_bloc.dart'
    as _i64;
import 'package:dalali_hub/app/pages/chat/bloc/set_messages_seen/set_messages_seen_bloc.dart'
    as _i65;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/add_images/add_images_bloc.dart'
    as _i48;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/create_realstate/create_realstate_bloc.dart'
    as _i52;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/delete_image/delete_image_bloc.dart'
    as _i54;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/delete_realstate/delete_realstate_bloc.dart'
    as _i55;
import 'package:dalali_hub/app/pages/create_update_delete_realstate/bloc/update_realstate/update_realstate_bloc.dart'
    as _i45;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/create_vehicle/create_vehicle_bloc.dart'
    as _i53;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/delete_vehicle/delete_vehicle_bloc.dart'
    as _i56;
import 'package:dalali_hub/app/pages/create_update_delete_vehicle/bloc/update_vehicle/update_vehicle_bloc.dart'
    as _i46;
import 'package:dalali_hub/app/pages/customer_home/bloc/feeds/feeds_bloc.dart'
    as _i28;
import 'package:dalali_hub/app/pages/favorite/bloc/add_to_my_favorite/add_to_my_favorite_bloc.dart'
    as _i26;
import 'package:dalali_hub/app/pages/favorite/bloc/get_my_favorites/get_my_favorites_bloc.dart'
    as _i29;
import 'package:dalali_hub/app/pages/favorite/bloc/remove_from_my_favorite/remove_from_my_favorite_bloc.dart'
    as _i23;
import 'package:dalali_hub/app/pages/forget_password/bloc/request_bloc/request_otp_bloc.dart'
    as _i41;
import 'package:dalali_hub/app/pages/forget_password/bloc/reset_password/reset_password_bloc_bloc.dart'
    as _i42;
import 'package:dalali_hub/app/pages/forget_password/bloc/verify_otp/verify_otp_bloc.dart'
    as _i47;
import 'package:dalali_hub/app/pages/profile/bloc/profile/profile_bloc.dart'
    as _i40;
import 'package:dalali_hub/app/pages/profile/bloc/update_profile_photo/update_profile_photo_bloc.dart'
    as _i44;
import 'package:dalali_hub/app/pages/property_detail_for_customer/bloc/get_property/get_property_bloc.dart'
    as _i31;
import 'package:dalali_hub/app/pages/property_filter/bloc/filter_realstate/filter_realstate_bloc.dart'
    as _i57;
import 'package:dalali_hub/app/pages/property_filter/bloc/filter_vehicle/filter_vehicle_bloc.dart'
    as _i58;
import 'package:dalali_hub/data/local/pref/pref.dart' as _i11;
import 'package:dalali_hub/data/remote/client/auth_client.dart' as _i27;
import 'package:dalali_hub/data/remote/client/favorite_client.dart' as _i14;
import 'package:dalali_hub/data/remote/client/feed_client.dart' as _i15;
import 'package:dalali_hub/data/remote/client/images_client.dart' as _i20;
import 'package:dalali_hub/data/remote/client/realstate_client.dart' as _i22;
import 'package:dalali_hub/data/remote/client/user_client.dart' as _i24;
import 'package:dalali_hub/data/remote/client/vehicle_client.dart' as _i25;
import 'package:dalali_hub/data/remote/config/network_config.dart' as _i7;
import 'package:dalali_hub/data/repository/auth_repository.dart' as _i33;
import 'package:dalali_hub/data/repository/chat_repository.dart' as _i51;
import 'package:dalali_hub/data/repository/favorite_repository.dart' as _i17;
import 'package:dalali_hub/data/repository/feed_repository.dart' as _i19;
import 'package:dalali_hub/data/repository/images_repository.dart' as _i35;
import 'package:dalali_hub/data/repository/realstate_repository.dart' as _i37;
import 'package:dalali_hub/data/repository/vehicle_repository.dart' as _i39;
import 'package:dalali_hub/di/app_module.dart' as _i67;
import 'package:dalali_hub/domain/config/network_config.dart' as _i6;
import 'package:dalali_hub/domain/repository/auth_repository.dart' as _i32;
import 'package:dalali_hub/domain/repository/chat_repository.dart' as _i50;
import 'package:dalali_hub/domain/repository/favorite_repository.dart' as _i16;
import 'package:dalali_hub/domain/repository/feed_repository.dart' as _i18;
import 'package:dalali_hub/domain/repository/images_repository.dart' as _i34;
import 'package:dalali_hub/domain/repository/realstate_repository.dart' as _i36;
import 'package:dalali_hub/domain/repository/vehicle_repository.dart' as _i38;
import 'package:dalali_hub/util/database_init.dart' as _i4;
import 'package:dalali_hub/util/jwt_interceptor.dart' as _i12;
import 'package:dalali_hub/util/log_interceptor.dart' as _i8;
import 'package:dalali_hub/util/realm.config.dart' as _i9;
import 'package:dio/dio.dart' as _i13;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:realm/realm.dart' as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i10;

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
    await gh.factoryAsync<_i4.AppDatabase>(
      () => appModule.appDatabase,
      preResolve: true,
    );
    gh.singleton<_i5.AuthCubit>(_i5.AuthCubit());
    gh.factory<_i6.INetworkConfig>(() => _i7.NetworkConfig());
    gh.singleton<_i8.LogInterceptor>(_i8.LogInterceptor());
    await gh.factoryAsync<_i9.RealmConfig>(
      () => appModule.realmConfig,
      preResolve: true,
    );
    await gh.factoryAsync<_i10.SharedPreferences>(
      () => appModule.prefs,
      preResolve: true,
    );
    gh.factory<_i11.SharedPreference>(
        () => _i11.SharedPreference(gh<_i10.SharedPreferences>()));
    gh.factory<_i12.JwtInterceptor>(
        () => _i12.JwtInterceptor(pref: gh<_i11.SharedPreference>()));
    gh.singleton<_i13.Dio>(appModule.dio(
      gh<_i6.INetworkConfig>(),
      gh<_i8.LogInterceptor>(),
      gh<_i12.JwtInterceptor>(),
    ));
    gh.singleton<_i14.FavoriteClient>(appModule.favoriteClient(gh<_i13.Dio>()));
    gh.singleton<_i15.FeedClient>(appModule.feedClient(gh<_i13.Dio>()));
    gh.lazySingleton<_i16.IFavoriteRepository>(
        () => _i17.FavoriteRepository(gh<_i14.FavoriteClient>()));
    gh.lazySingleton<_i18.IFeedRepository>(() => _i19.FeedRepository(
          gh<_i15.FeedClient>(),
          gh<_i4.AppDatabase>(),
        ));
    gh.singleton<_i20.ImagesClient>(appModule.imageClient(gh<_i13.Dio>()));
    gh.factory<_i21.MyListingBloc>(
        () => _i21.MyListingBloc(gh<_i18.IFeedRepository>()));
    gh.singleton<_i22.RealstateClient>(
        appModule.realstateClient(gh<_i13.Dio>()));
    gh.factory<_i23.RemoveFromMyFavoriteBloc>(
        () => _i23.RemoveFromMyFavoriteBloc(gh<_i16.IFavoriteRepository>()));
    gh.singleton<_i24.UserClient>(appModule.userClient(gh<_i13.Dio>()));
    gh.singleton<_i25.VehicleClient>(appModule.vehicleClient(gh<_i13.Dio>()));
    gh.factory<_i26.AddToMyFavoriteBloc>(
        () => _i26.AddToMyFavoriteBloc(gh<_i16.IFavoriteRepository>()));
    gh.singleton<_i27.AuthClient>(appModule.authClient(gh<_i13.Dio>()));
    gh.factory<_i28.FeedsBloc>(
        () => _i28.FeedsBloc(gh<_i18.IFeedRepository>()));
    gh.factory<_i29.GetMyFavoritesBloc>(
        () => _i29.GetMyFavoritesBloc(gh<_i16.IFavoriteRepository>()));
    gh.factory<_i30.GetMyStatBloc>(
        () => _i30.GetMyStatBloc(gh<_i18.IFeedRepository>()));
    gh.factory<_i31.GetPropertyBloc>(() => _i31.GetPropertyBloc(
          gh<_i18.IFeedRepository>(),
          gh<_i16.IFavoriteRepository>(),
        ));
    gh.lazySingleton<_i32.IAuthRepository>(() => _i33.AuthRepository(
          gh<_i27.AuthClient>(),
          gh<_i11.SharedPreference>(),
          gh<_i3.App>(),
        ));
    gh.lazySingleton<_i34.IImagesRepository>(
        () => _i35.ImagesRepository(gh<_i20.ImagesClient>()));
    gh.lazySingleton<_i36.IRealstateRepository>(
        () => _i37.RealstateRepository(gh<_i22.RealstateClient>()));
    gh.lazySingleton<_i38.IVehicleRepository>(
        () => _i39.VehicleRepository(gh<_i25.VehicleClient>()));
    gh.factory<_i40.ProfileBloc>(
        () => _i40.ProfileBloc(gh<_i32.IAuthRepository>()));
    gh.factory<_i41.RequestOtpBloc>(
        () => _i41.RequestOtpBloc(gh<_i32.IAuthRepository>()));
    gh.factory<_i42.ResetPasswordBloc>(
        () => _i42.ResetPasswordBloc(gh<_i32.IAuthRepository>()));
    gh.factory<_i43.SignupBloc>(
        () => _i43.SignupBloc(gh<_i32.IAuthRepository>()));
    gh.factory<_i44.UpdateProfilePhotoBloc>(
        () => _i44.UpdateProfilePhotoBloc(gh<_i32.IAuthRepository>()));
    gh.factory<_i45.UpdateRealstateBloc>(
        () => _i45.UpdateRealstateBloc(gh<_i36.IRealstateRepository>()));
    gh.factory<_i46.UpdateVehicleBloc>(
        () => _i46.UpdateVehicleBloc(gh<_i38.IVehicleRepository>()));
    gh.factory<_i47.VerifyOtpBloc>(
        () => _i47.VerifyOtpBloc(gh<_i32.IAuthRepository>()));
    gh.factory<_i48.AddImagesBloc>(
        () => _i48.AddImagesBloc(gh<_i34.IImagesRepository>()));
    gh.singleton<_i49.AuthBloc>(_i49.AuthBloc(
      gh<_i11.SharedPreference>(),
      gh<_i32.IAuthRepository>(),
    ));
    gh.singleton<_i50.ChatRepository>(_i51.ChatRepositoryImpl(
      gh<_i9.RealmConfig>(),
      gh<_i3.App>(),
      gh<_i11.SharedPreference>(),
      gh<_i32.IAuthRepository>(),
    ));
    gh.factory<_i52.CreateRealstateBloc>(
        () => _i52.CreateRealstateBloc(gh<_i36.IRealstateRepository>()));
    gh.factory<_i53.CreateVehicleBloc>(
        () => _i53.CreateVehicleBloc(gh<_i38.IVehicleRepository>()));
    gh.factory<_i54.DeleteImageBloc>(
        () => _i54.DeleteImageBloc(gh<_i34.IImagesRepository>()));
    gh.factory<_i55.DeleteRealstateBloc>(
        () => _i55.DeleteRealstateBloc(gh<_i36.IRealstateRepository>()));
    gh.factory<_i56.DeleteVehicleBloc>(
        () => _i56.DeleteVehicleBloc(gh<_i38.IVehicleRepository>()));
    gh.factory<_i57.FilterRealstateBloc>(
        () => _i57.FilterRealstateBloc(gh<_i36.IRealstateRepository>()));
    gh.factory<_i58.FilterVehicleBloc>(
        () => _i58.FilterVehicleBloc(gh<_i38.IVehicleRepository>()));
    gh.factory<_i59.GetMessagesBloc>(
        () => _i59.GetMessagesBloc(gh<_i50.ChatRepository>()));
    gh.factory<_i60.GetRoomBloc>(() => _i60.GetRoomBloc(
          gh<_i11.SharedPreference>(),
          gh<_i50.ChatRepository>(),
        ));
    gh.singleton<_i61.GetRoomsBloc>(
        _i61.GetRoomsBloc(gh<_i50.ChatRepository>()));
    gh.factory<_i62.LoginBloc>(() => _i62.LoginBloc(
          gh<_i32.IAuthRepository>(),
          gh<_i49.AuthBloc>(),
        ));
    gh.factory<_i63.LogoutBloc>(() => _i63.LogoutBloc(
          gh<_i49.AuthBloc>(),
          gh<_i32.IAuthRepository>(),
        ));
    gh.factory<_i64.SendMessageBloc>(
        () => _i64.SendMessageBloc(gh<_i50.ChatRepository>()));
    gh.factory<_i65.SetMessagesSeenBloc>(
        () => _i65.SetMessagesSeenBloc(gh<_i50.ChatRepository>()));
    gh.singleton<_i66.AppRouter>(_i66.AppRouter(gh<_i49.AuthBloc>()));
    return this;
  }
}

class _$AppModule extends _i67.AppModule {}
