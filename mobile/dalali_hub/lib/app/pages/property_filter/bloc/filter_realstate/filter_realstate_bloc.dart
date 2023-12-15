import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/filter_parameter.dart';
import 'package:dalali_hub/domain/entity/realstate_response.dart';
import 'package:dalali_hub/domain/repository/realstate_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'filter_realstate_event.dart';
part 'filter_realstate_state.dart';
part 'filter_realstate_bloc.freezed.dart';

@injectable
class FilterRealstateBloc extends Bloc<FilterRealstateEvent, FilterRealstateState> {
  final IRealstateRepository _realstateRepository;

  FilterRealstateBloc(this._realstateRepository) : super(const _Initial()) {
    on<_FilterRealstate>((event, emit) async {
      emit(const _Loading());
      var response = await _realstateRepository.getRealstates(event.filterParameter);
      response.fold(onSuccess: (data) {
        emit(_Success(response.data!));
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
