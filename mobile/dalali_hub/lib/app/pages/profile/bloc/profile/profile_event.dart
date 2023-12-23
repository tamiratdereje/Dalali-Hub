part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.started() = _Started;
  const factory ProfileEvent.profile() = _Profile;
  const factory ProfileEvent.updateProfile(User user) = _UpdateProfile;
  const factory ProfileEvent.getOtherProfile(String id) = _GetOtherProfile;
}
