part of 'update_house_bloc.dart';

@freezed
class UpdateHouseEvent with _$UpdateHouseEvent {
  const factory UpdateHouseEvent.started() = _Started;
  const factory UpdateHouseEvent.UpdateHouse({
    required House house,
  }) = _UpdateHouse;
}