part of 'delete_realstate_bloc.dart';

@freezed
class DeleteRealstateEvent with _$DeleteRealstateEvent {
  const factory DeleteRealstateEvent.started() = _Started;
  const factory DeleteRealstateEvent.deleteRealstate({
    required String realstateId,
  }) = _DeleteRealstate;
}