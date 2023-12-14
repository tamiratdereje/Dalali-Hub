part of 'delete_vehicle_bloc.dart';

@freezed
class DeleteVehicleState with _$DeleteVehicleState {
  const factory DeleteVehicleState.initial() = _Initial;
  const factory DeleteVehicleState.loading() = _Loading;
  const factory DeleteVehicleState.success() = _Success;
  const factory DeleteVehicleState.error(String message) = _Error;
}
