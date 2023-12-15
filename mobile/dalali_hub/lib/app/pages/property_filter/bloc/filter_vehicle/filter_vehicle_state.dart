part of 'filter_vehicle_bloc.dart';


@freezed
class FilterVehicleState with _$FilterVehicleState {
  const factory FilterVehicleState.initial() = _Initial;
  const factory FilterVehicleState.loading() = _Loading;
  const factory FilterVehicleState.success(List<VehicleResponse> vehicles) = _Success;
  const factory FilterVehicleState.error(String message) = _Error;
}
