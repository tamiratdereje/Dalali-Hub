part of 'delete_house_bloc.dart';

@freezed
class DeleteHouseEvent with _$DeleteHouseEvent {
  const factory DeleteHouseEvent.started() = _Started;
  const factory DeleteHouseEvent.deleteHouse({
    required String houseId,
  }) = _DeleteHouse;
}