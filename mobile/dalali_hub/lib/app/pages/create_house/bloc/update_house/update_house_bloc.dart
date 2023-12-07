import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/house.dart';
import 'package:dalali_hub/domain/repository/house_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'update_house_event.dart';
part 'update_house_state.dart';
part 'update_house_bloc.freezed.dart';

@injectable
class UpdateHouseBloc extends Bloc<UpdateHouseEvent, UpdateHouseState> {
  final IHouseRepository _houseRepository;

  UpdateHouseBloc(this._houseRepository) : super(const _Initial()) {
    on<_UpdateHouse>((event, emit) async {
      emit(const _Loading());
      var response = await _houseRepository.updateHouse(event.house);
      response.fold(onSuccess: (data) {
        emit(const _Success());
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
