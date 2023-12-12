part of 'update_realstate_bloc.dart';

@freezed
class UpdateRealstateEvent with _$UpdateRealstateEvent {
  const factory UpdateRealstateEvent.started() = _Started;
  const factory UpdateRealstateEvent.updateRealstate({
    required Realstate realstate,
  }) = _UpdateRealstate;
}