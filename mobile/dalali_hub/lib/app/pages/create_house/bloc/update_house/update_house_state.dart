part of 'update_house_bloc.dart';

@freezed
class UpdateHouseState with _$UpdateHouseState {
  const factory UpdateHouseState.initial() = _Initial;
  const factory UpdateHouseState.loading() = _Loading;
  const factory UpdateHouseState.success() = _Success;
  const factory UpdateHouseState.error(String message) = _Error;
}
