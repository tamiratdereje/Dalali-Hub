part of 'get_rooms_bloc.dart';

@freezed
class GetRoomsEvent with _$GetRoomsEvent {
  const factory GetRoomsEvent.started() = _Started;
  const factory GetRoomsEvent.getRooms() = _GetRooms;
}