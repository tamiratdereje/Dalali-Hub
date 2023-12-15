part of 'filter_realstate_bloc.dart';


@freezed
class FilterRealstateState with _$FilterRealstateState {
  const factory FilterRealstateState.initial() = _Initial;
  const factory FilterRealstateState.loading() = _Loading;
  const factory FilterRealstateState.success(List<RealstateResponse> realstates) = _Success;
  const factory FilterRealstateState.error(String message) = _Error;
}
