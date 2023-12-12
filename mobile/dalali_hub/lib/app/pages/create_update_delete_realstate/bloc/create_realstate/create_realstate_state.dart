part of 'create_realstate_bloc.dart';

@freezed
class CreateRealstateState with _$CreateRealstateState {
  const factory CreateRealstateState.initial() = _Initial;
  const factory CreateRealstateState.loading() = _Loading;
  const factory CreateRealstateState.success() = _Success;
  const factory CreateRealstateState.error(String message) = _Error;
}
