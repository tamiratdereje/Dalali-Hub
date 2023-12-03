part of 'create_house_bloc.dart';

@freezed
class CreateHouseEvent with _$CreateHouseEvent {
  const factory CreateHouseEvent.started() = _Started;
  const factory CreateHouseEvent.createHouse({
    required House house,
  }) = _CreateHouse;
}