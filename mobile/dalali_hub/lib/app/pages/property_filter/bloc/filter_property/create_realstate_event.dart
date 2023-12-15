part of 'create_realstate_bloc.dart';


@freezed
class CreateRealstateEvent with _$CreateRealstateEvent {
  const factory CreateRealstateEvent.started() = _Started;
  const factory CreateRealstateEvent.realstate({
    required Realstate realstate,
  }) = _CreateRealstate;
}