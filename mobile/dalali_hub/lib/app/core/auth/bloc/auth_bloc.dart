import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/login.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
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
  final IAuthRepository _authRepository;
  AuthBloc(this._authCubit, this._authRepository) : super(const _Initial()) {
    on<_UpdateAuthStatus>((event, emit) async {
      var response = await _authRepository.login(Login(email: '', password: ''));
      debugPrint('AuthBloc: ${response.toString()}'); 
      var token = SharedPreference.getString(tokenKey);
      if (token != null) {
        _authCubit.authenticated();
      } else {
        _authCubit.unauthenticated();
      }
    });
  }
}
