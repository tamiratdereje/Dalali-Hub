part of 'filter_vehicle_bloc.dart';


@freezed
class FilterVehicleEvent with _$FilterVehicleEvent {
  const factory FilterVehicleEvent.started() = _Started;
  const factory FilterVehicleEvent.vehicle({
    required FilterParameter filterParameter,
  }) = _FilterVehicle;
}