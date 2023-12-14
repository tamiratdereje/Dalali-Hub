part of 'delete_vehicle_bloc.dart';

@freezed
class DeleteVehicleEvent with _$DeleteVehicleEvent {
  const factory DeleteVehicleEvent.started() = _Started;
  const factory DeleteVehicleEvent.deleteVehicle({
    required String vehicleId,
  }) = _DeleteVehicle;
}