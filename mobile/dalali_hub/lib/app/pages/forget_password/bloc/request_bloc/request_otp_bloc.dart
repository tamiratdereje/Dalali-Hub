import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/verify_otp.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'request_otp_event.dart';
part 'request_otp_state.dart';

part 'request_otp_bloc.freezed.dart';

@injectable
class RequestOtpBloc extends Bloc<RequestOtpEvent, RequestOtpState> {
  final IAuthRepository _authRepository;
  RequestOtpBloc(this._authRepository) : super(const _Initial()) {
    on<_RequestOtp>((event, emit) async {
      emit(const RequestOtpState.loading());
      var response = await _authRepository.resendOtp(event.verifyOtp);
      response.fold(
          onSuccess: (_) => emit(const RequestOtpState.sent()),
          onError: (error) => emit(RequestOtpState.error(error.message)));
    });
  }
}
