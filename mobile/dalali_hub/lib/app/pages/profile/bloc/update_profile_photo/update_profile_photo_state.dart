part of 'update_profile_photo_bloc.dart';

@freezed
class UpdateProfilePhotoState with _$UpdateProfilePhotoState {
  const factory UpdateProfilePhotoState.initial() = _Initial;
  const factory UpdateProfilePhotoState.loading() = _Loading;
  const factory UpdateProfilePhotoState.success(List<PhotoResponse> photos) = _Success;
  const factory UpdateProfilePhotoState.error(String message) = _Error;
}
