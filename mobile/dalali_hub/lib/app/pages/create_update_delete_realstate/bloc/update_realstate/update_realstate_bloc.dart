import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/realstate.dart';
import 'package:dalali_hub/domain/repository/realstate_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'update_realstate_event.dart';
part 'update_realstate_state.dart';
part 'update_realstate_bloc.freezed.dart';

@injectable
class UpdateRealstateBloc extends Bloc<UpdateRealstateEvent, UpdateRealstateState> {
  final IRealstateRepository _realstateRepository;

  UpdateRealstateBloc(this._realstateRepository) : super(const _Initial()) {
    on<_UpdateRealstate>((event, emit) async {
      emit(const _Loading());
      var response = await _realstateRepository.updateRealstate(event.realstate);
      response.fold(onSuccess: (data) {
        emit(const _Success());
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
