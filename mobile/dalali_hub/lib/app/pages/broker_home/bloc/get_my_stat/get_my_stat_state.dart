

part of 'get_my_stat_bloc.dart';

@freezed
class GetMyStatState with _$GetMyStatState {
  const factory GetMyStatState.initial() = _Initial;
  const factory GetMyStatState.loading() = _Loading;
  const factory GetMyStatState.success(BrokerStat brokerStat) = _Success;
  const factory GetMyStatState.error(String message) = _Error;
}
