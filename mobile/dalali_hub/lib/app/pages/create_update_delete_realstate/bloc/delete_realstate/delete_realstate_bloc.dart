import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/repository/realstate_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'delete_realstate_event.dart';
part 'delete_realstate_state.dart';
part 'delete_realstate_bloc.freezed.dart';

@injectable
class DeleteRealstateBloc extends Bloc<DeleteRealstateEvent, DeleteRealstateState> {
  final IRealstateRepository _realstateRepository;

  DeleteRealstateBloc(this._realstateRepository) : super(const _Initial()) {
    on<_DeleteRealstate>((event, emit) async {
      emit(const _Loading());
      var response = await _realstateRepository.deleteRealstate(event.realstateId);
      response.fold(onSuccess: (data) {
        emit(const _Success());
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
