import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/realstate.dart';
import 'package:dalali_hub/domain/repository/realstate_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'create_realstate_event.dart';
part 'create_realstate_state.dart';
part 'create_realstate_bloc.freezed.dart';

@injectable
class CreateRealstateBloc extends Bloc<CreateRealstateEvent, CreateRealstateState> {
  final IRealstateRepository _realstateRepository;

  CreateRealstateBloc(this._realstateRepository) : super(const _Initial()) {
    on<_CreateRealstate>((event, emit) async {
      emit(const _Loading());
      var response = await _realstateRepository.addRealstate(event.realstate);
      response.fold(onSuccess: (data) {
        emit(const _Success());
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
