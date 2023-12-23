import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/repository/auth_repository.dart';
import 'package:dalali_hub/domain/repository/images_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'update_profile_photo_event.dart';
part 'update_profile_photo_state.dart';
part 'update_profile_photo_bloc.freezed.dart';

@injectable
class UpdateProfilePhotoBloc extends Bloc<UpdateProfilePhotoEvent, UpdateProfilePhotoState> {
  final IAuthRepository _authRepository;

  UpdateProfilePhotoBloc(this._authRepository) : super(const _Initial()) {
    on<_UpdateProfilePhoto>((event, emit) async {
      emit(const _Loading());
      var response = await _authRepository.updateProfilePicture(event.photos);
      response.fold(onSuccess: (data) {
        emit(_Success(data));
        
      }, onError: (error) {
          emit(_Error(error.message));
      });
    });
  }
}
