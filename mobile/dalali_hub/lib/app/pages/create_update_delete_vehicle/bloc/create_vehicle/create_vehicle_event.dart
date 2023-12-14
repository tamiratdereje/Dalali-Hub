part of 'create_vehicle_bloc.dart';


@freezed
class CreateVehicleEvent with _$CreateVehicleEvent {
  const factory CreateVehicleEvent.started() = _Started;
  const factory CreateVehicleEvent.vehicle({
    required Vehicle vehicle,
  }) = _CreateVehicle;
}