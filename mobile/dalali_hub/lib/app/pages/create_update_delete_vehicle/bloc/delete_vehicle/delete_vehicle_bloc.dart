import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/repository/vehicle_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'delete_vehicle_event.dart';
part 'delete_vehicle_state.dart';
part 'delete_vehicle_bloc.freezed.dart';

@injectable
class DeleteVehicleBloc extends Bloc<DeleteVehicleEvent, DeleteVehicleState> {
  final IVehicleRepository _vehicleRepository;

  DeleteVehicleBloc(this._vehicleRepository) : super(const _Initial()) {
    on<_DeleteVehicle>((event, emit) async {
      emit(const _Loading());
      var response = await _vehicleRepository.deleteVehicle(event.vehicleId);
      response.fold(onSuccess: (data) {
        emit(const _Success());
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
