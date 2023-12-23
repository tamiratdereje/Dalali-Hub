part of 'update_profile_photo_bloc.dart';

@freezed
class UpdateProfilePhotoEvent with _$UpdateProfilePhotoEvent {
  const factory UpdateProfilePhotoEvent.started() = _Started;
  const factory UpdateProfilePhotoEvent.updateProfilePhoto({
    required List<String> photos,
  }) = _UpdateProfilePhoto;
}