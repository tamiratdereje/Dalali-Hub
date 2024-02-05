import 'package:bloc/bloc.dart';
import 'package:dalali_hub/data/remote/model/realm/realm_models.dart';
import 'package:dalali_hub/data/remote/model/realm/room_wrapper.dart';
import 'package:dalali_hub/domain/repository/chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'get_rooms_event.dart';
part 'get_rooms_state.dart';
part 'get_rooms_bloc.freezed.dart';

@singleton
class GetRoomsBloc extends Bloc<GetRoomsEvent, GetRoomsState> {
  final ChatRepository _chatRepository;
  GetRoomsBloc(this._chatRepository) : super(const _Initial()) {
    on<_GetRooms>((event, emit) async {
      emit(const _Loading());
      await emit.forEach(
        _chatRepository.getRooms(),
        onData: (rooms) {
          print(rooms);
          return _Success(rooms);
        },
        onError: (e, s) => _Error(e.toString()),
      );
    });
  }
}
