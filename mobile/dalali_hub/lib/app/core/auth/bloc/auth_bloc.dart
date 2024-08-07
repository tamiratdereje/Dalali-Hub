import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/app/core/auth/cubit/auth_cubit.dart';
import 'package:dalali_hub/constants/string_constants.dart';
import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthCubit _authCubit;
  final SharedPreference _sharedPreference;
  AuthBloc(this._authCubit, this._sharedPreference) : super(const _Initial()) {
    on<_UpdateAuthStatus>((event, emit) async {
      var isFirstTime = _sharedPreference.getBool(firstTimeUseKey);
      if (isFirstTime == null || isFirstTime) {
        _authCubit.firstTime();
        await _sharedPreference.setBool(firstTimeUseKey, false);
        return;
      }
      var token = _sharedPreference.getString(tokenKey);
      if (token != null) {
        _authCubit.authenticated();
      } else {
        _authCubit.unauthenticated();
      }
    });
  }
}
