import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/filter_parameter.dart';
import 'package:dalali_hub/domain/entity/vehicle_response.dart';
import 'package:dalali_hub/domain/repository/vehicle_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'filter_vehicle_event.dart';
part 'filter_vehicle_state.dart';
part 'filter_vehicle_bloc.freezed.dart';

@injectable
class FilterVehicleBloc extends Bloc<FilterVehicleEvent, FilterVehicleState> {
  final IVehicleRepository _vehicleRepository;

  FilterVehicleBloc(this._vehicleRepository) : super(const _Initial()) {
    on<_FilterVehicle>((event, emit) async {
      emit(const _Loading());
      var response = await _vehicleRepository.getVehicles(event.filterParameter);
      response.fold(onSuccess: (data) {
        emit(_Success(response.data!));
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
