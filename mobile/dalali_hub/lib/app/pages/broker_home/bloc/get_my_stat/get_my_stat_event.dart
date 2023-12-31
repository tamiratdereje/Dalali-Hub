part of 'get_my_stat_bloc.dart';

@freezed
class GetMyStatEvent with _$GetMyStatEvent {
  const factory GetMyStatEvent.started() = _Started;
  const factory GetMyStatEvent.getMyStat() = _GetMyStat;
}
