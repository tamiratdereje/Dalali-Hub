import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/vehicle.dart';
import 'package:dalali_hub/domain/repository/vehicle_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'create_vehicle_event.dart';
part 'create_vehicle_state.dart';
part 'create_vehicle_bloc.freezed.dart';

@injectable
class CreateVehicleBloc extends Bloc<CreateVehicleEvent, CreateVehicleState> {
  final IVehicleRepository _vehicleRepository;

  CreateVehicleBloc(this._vehicleRepository) : super(const _Initial()) {
    on<_CreateVehicle>((event, emit) async {
      emit(const _Loading());
      var response = await _vehicleRepository.addVehicle(event.vehicle);
      response.fold(onSuccess: (data) {
        emit(const _Success());
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
