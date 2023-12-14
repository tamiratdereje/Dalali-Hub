import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/vehicle.dart';
import 'package:dalali_hub/domain/repository/vehicle_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'update_vehicle_event.dart';
part 'update_vehicle_state.dart';
part 'update_vehicle_bloc.freezed.dart';

@injectable
class UpdateVehicleBloc extends Bloc<UpdateVehicleEvent, UpdateVehicleState> {
  final IVehicleRepository _vehicleRepository;

  UpdateVehicleBloc(this._vehicleRepository) : super(const _Initial()) {
    on<_UpdateVehicle>((event, emit) async {
      emit(const _Loading());
      var response = await _vehicleRepository.updateVehicle(event.vehicle);
      response.fold(onSuccess: (data) {
        emit(const _Success());
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
