part of 'get_room_bloc.dart';

@freezed
class GetRoomState with _$GetRoomState {
  const factory GetRoomState.initial() = _Initial;
  const factory GetRoomState.loading() = _Loading;
  const factory GetRoomState.success(RoomWrapper room) = _Success;
  const factory GetRoomState.error(String message) = _Error;
}
