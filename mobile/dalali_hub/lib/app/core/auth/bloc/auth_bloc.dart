import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';
part 'auth_bloc.freezed.dart';

@singleton
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SharedPreference _sharedPreference;
  final IAuthRepository _authRepository;
  AuthBloc(this._sharedPreference, this._authRepository)
      : super(const _Initial()) {
    on<_UpdateAuthStatus>(
      (event, emit) async {
        var user = _sharedPreference.getUserAuthDetails();
        if (user != null) {
          try {
            await _authRepository.loginToRealm(user.token);
            emit(const AuthState.authenticated());
          } catch (e) {
            emit(const AuthState.authenticated());
          }
        } else {
          var isFirstTime = _sharedPreference.getBool("firstTime");
          if (isFirstTime == null || isFirstTime == true) {
            emit(const AuthState.firstTime());
            await _sharedPreference.setBool("firstTime", false);
          } else {
            emit(const AuthState.unauthenticated());
          }
        }
      },
    );

    on<_Authenticate>((event, emit) async {
      emit(const AuthState.authenticated());
    });

    on<_Unauthenticate>((event, emit) async {
      emit(const AuthState.unauthenticated());
    });
  }
}
