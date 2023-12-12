part of 'update_vehicle_bloc.dart';

@freezed
class UpdateVehicleState with _$UpdateVehicleState {
  const factory UpdateVehicleState.initial() = _Initial;
  const factory UpdateVehicleState.loading() = _Loading;
  const factory UpdateVehicleState.success() = _Success;
  const factory UpdateVehicleState.error(String message) = _Error;
}
