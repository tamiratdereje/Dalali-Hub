import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/signup.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'signup_event.dart';
part 'signup_state.dart';
part 'signup_bloc.freezed.dart';

@injectable
class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final IAuthRepository _authRepository;
  SignupBloc(this._authRepository) : super(const _Initial()) {
    on<_Signup>((event, emit) async {
      emit(const SignupState.loading());
      var response = await _authRepository.register(event.signupForm);
      response.fold(
        onSuccess: (_) => emit(const SignupState.success()),
        onError: (
          error,
        ) =>
            emit(SignupState.error(error.message)),
      );
    });
  }
}
