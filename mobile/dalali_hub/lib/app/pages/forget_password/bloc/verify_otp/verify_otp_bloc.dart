import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/verify_otp.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

part 'verify_otp_bloc.freezed.dart';

@injectable
class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final IAuthRepository _authRepository;
  VerifyOtpBloc(this._authRepository) : super(const _Initial()) {
    on<_Verify>((event, emit) async {
      emit(const VerifyOtpState.loading());
      var response = await _authRepository.verifyOtp(event.verifyOtp);
      response.fold(
          onSuccess: (_) => emit(const VerifyOtpState.verified()),
          onError: (error) => emit(VerifyOtpState.error(error.message)));
    });
  }
}
