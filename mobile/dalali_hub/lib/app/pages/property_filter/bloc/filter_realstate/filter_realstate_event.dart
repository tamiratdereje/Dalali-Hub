part of 'filter_realstate_bloc.dart';


@freezed
class FilterRealstateEvent with _$FilterRealstateEvent {
  const factory FilterRealstateEvent.started() = _Started;
  const factory FilterRealstateEvent.realstate({
    required FilterParameter filterParameter,
  }) = _FilterRealstate;
}