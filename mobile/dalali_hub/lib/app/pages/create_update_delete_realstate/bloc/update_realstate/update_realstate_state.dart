part of 'update_realstate_bloc.dart';

@freezed
class UpdateRealstateState with _$UpdateRealstateState {
  const factory UpdateRealstateState.initial() = _Initial;
  const factory UpdateRealstateState.loading() = _Loading;
  const factory UpdateRealstateState.success() = _Success;
  const factory UpdateRealstateState.error(String message) = _Error;
}
