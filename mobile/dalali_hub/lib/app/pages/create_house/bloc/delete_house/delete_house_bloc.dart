import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/repository/house_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'delete_house_event.dart';
part 'delete_house_state.dart';
part 'delete_house_bloc.freezed.dart';

@injectable
class DeleteHouseBloc extends Bloc<DeleteHouseEvent, DeleteHouseState> {
  final IHouseRepository _houseRepository;

  DeleteHouseBloc(this._houseRepository) : super(const _Initial()) {
    on<_DeleteHouse>((event, emit) async {
      emit(const _Loading());
      var response = await _houseRepository.deleteHouse(event.houseId);
      response.fold(onSuccess: (data) {
        emit(const _Success());
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
