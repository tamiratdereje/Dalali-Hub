part of 'update_vehicle_bloc.dart';

@freezed
class UpdateVehicleEvent with _$UpdateVehicleEvent {
  const factory UpdateVehicleEvent.started() = _Started;
  const factory UpdateVehicleEvent.updateVehicle({
    required Vehicle vehicle,
  }) = _UpdateVehicle;
}