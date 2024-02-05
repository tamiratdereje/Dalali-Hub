import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dalali_hub/app/core/auth/bloc/auth_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/app/core/auth/cubit/auth_cubit.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'logout_event.dart';
part 'logout_state.dart';
part 'logout_bloc.freezed.dart';

@injectable
class LogoutBloc extends Bloc<LogoutEvent, LogoutState> {
  final AuthBloc _authBloc;
  final IAuthRepository _authRepository;
  LogoutBloc(this._authBloc, this._authRepository) : super(const _Initial()) {
    on<_Logout>((event, emit) async {
      var response = await _authRepository.logout();
      response.fold(
          onSuccess: (data) {
            _authBloc.add(const AuthEvent.unauthenticate());
            sleep(const Duration(seconds: 1));
            emit(const _Success());
          },
          onError: (error) => emit(_Error(error.message)));
    });
  }
}
