part of 'create_house_bloc.dart';

@freezed
class CreateHouseState with _$CreateHouseState {
  const factory CreateHouseState.initial() = _Initial;
  const factory CreateHouseState.loading() = _Loading;
  const factory CreateHouseState.success() = _Success;
  const factory CreateHouseState.error(String message) = _Error;
}
