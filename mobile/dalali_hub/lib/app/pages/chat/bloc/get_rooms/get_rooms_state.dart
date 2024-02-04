part of 'get_rooms_bloc.dart';

@freezed
class GetRoomsState with _$GetRoomsState {
  const factory GetRoomsState.initial() = _Initial;
  const factory GetRoomsState.loading() = _Loading;
  const factory GetRoomsState.success(List<Rooms> rooms) = _Success;
  const factory GetRoomsState.error(String message) = _Error;
}