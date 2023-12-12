part of 'create_vehicle_bloc.dart';

@freezed
class CreateVehicleState with _$CreateVehicleState {
  const factory CreateVehicleState.initial() = _Initial;
  const factory CreateVehicleState.loading() = _Loading;
  const factory CreateVehicleState.success() = _Success;
  const factory CreateVehicleState.error(String message) = _Error;
}
