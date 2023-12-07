part of 'delete_house_bloc.dart';

@freezed
class DeleteHouseState with _$DeleteHouseState {
  const factory DeleteHouseState.initial() = _Initial;
  const factory DeleteHouseState.loading() = _Loading;
  const factory DeleteHouseState.success() = _Success;
  const factory DeleteHouseState.error(String message) = _Error;
}
