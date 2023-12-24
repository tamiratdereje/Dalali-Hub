import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/entity/user.dart';
import 'package:dalali_hub/domain/entity/user_response.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:dalali_hub/domain/repository/images_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IAuthRepository _authRepository;

  ProfileBloc( this._authRepository) : super(const _Initial()) {
    on<_Profile>((event, emit) async {
      emit(const _Loading());
      debugPrint("Bloc profile called");
      var response = await _authRepository.getMyProfile();
      response.fold(onSuccess: (data) {
        emit(_Success(data));
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
    on<_UpdateProfile>((event, emit) async {
      emit(const _Loading());
      var response = await _authRepository.updateProfile(event.user);
      response.fold(onSuccess: (data) {
        emit(_Success(data));
      }, onError: (error) {
        emit(_Error(error.message));
      });
    });
    on<_GetOtherProfile>((event, emit) async {
      emit(const _Loading());
      var response = await _authRepository.getOtherProfile(event.id);
      response.fold(onSuccess: (data) {
        emit(_Success(data));
      }, onError: (error) {
        emit(_Error(error.message));
      });
    });

    on<_UpdateProfilePicture>((event, emit) async {
      final state = this.state;
      debugPrint("Current state after adding to favorite ${state.toString()}");
      if (state is _Success) {
        // Clone the current state
        final currentState = state;
        currentState.userResponse.photos = event.photos;
        emit(_Success(currentState.userResponse));
      }
      
    });
  } 
}
