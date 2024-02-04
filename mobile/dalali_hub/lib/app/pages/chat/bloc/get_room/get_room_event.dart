part of 'get_room_bloc.dart';

@freezed
class GetRoomEvent with _$GetRoomEvent {
  const factory GetRoomEvent.started() = _Started;
  const factory GetRoomEvent.getRoom(String recieverId) = _GetRoom;
}
