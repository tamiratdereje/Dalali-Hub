import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/reset_password.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'reset_password_bloc_event.dart';
part 'reset_password_bloc_state.dart';

part 'reset_password_bloc_bloc.freezed.dart';

@injectable
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final IAuthRepository _authRepository;
  ResetPasswordBloc(this._authRepository) : super(const _Initial()) {
    on<_ResetPassword>(
      (event, emit) async {
        emit(const ResetPasswordState.loading());
        var response = await _authRepository.resetPassword(event.resetPassword);
        response.fold(
          onSuccess: (_) => emit(const ResetPasswordState.success()),
          onError: (error) {
            if (error.statusCode == 401) {
              emit(ResetPasswordState.tokenExpired(error.message));
            } else {
              emit(ResetPasswordState.error(error.message));
            }
          },
        );
      },
    );
  }
}
