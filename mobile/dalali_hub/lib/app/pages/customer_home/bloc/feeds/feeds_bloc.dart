import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/repository/feed_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'feeds_event.dart';
part 'feeds_state.dart';
part 'feeds_bloc.freezed.dart';

@injectable
class FeedsBloc extends Bloc<FeedsEvent, FeedsState> {
  final IFeedRepository _feedRepository;

  FeedsBloc(this._feedRepository) : super(const _Initial()) {
    on<_Feeds>((event, emit) async {
      emit(const _Loading());
      var response = await _feedRepository.getAllFeeds();
      response.fold(onSuccess: (data) {
        emit(_Success(data));
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
