part of 'delete_realstate_bloc.dart';

@freezed
class DeleteRealstateState with _$DeleteRealstateState {
  const factory DeleteRealstateState.initial() = _Initial;
  const factory DeleteRealstateState.loading() = _Loading;
  const factory DeleteRealstateState.success() = _Success;
  const factory DeleteRealstateState.error(String message) = _Error;
}
