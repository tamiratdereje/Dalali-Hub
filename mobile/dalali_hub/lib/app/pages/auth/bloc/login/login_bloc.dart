import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/app/core/auth/cubit/auth_cubit.dart';
import 'package:dalali_hub/domain/entity/login.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'login_event.dart';
part 'login_state.dart';
part 'login_bloc.freezed.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final IAuthRepository _authRepository;
  final AuthBloc _authBloc;
  LoginBloc(this._authRepository, this._authBloc) : super(const _Initial()) {
    on<_Login>((event, emit) async {
      emit(const _Loading());
      var response = await _authRepository.login(event.login);
      response.fold(onSuccess: (data) {
        _authBloc.add(const AuthEvent.authenticate());
        sleep(const Duration(seconds: 1));
        emit(const _Success());
      }, onError: (error) {
        if (error.statusCode != null && error.statusCode == 401) {
          emit(const LoginState.unVerified());
        } else {
          emit(LoginState.error(error.message));
        }
      });
    });
  }
}
