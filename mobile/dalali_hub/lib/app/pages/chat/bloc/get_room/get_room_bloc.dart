import 'package:bloc/bloc.dart';
import 'package:dalali_hub/data/local/pref/pref.dart';
import 'package:dalali_hub/data/remote/model/realm/realm_models.dart';
import 'package:dalali_hub/domain/repository/chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:realm/realm.dart';

part 'get_room_event.dart';
part 'get_room_state.dart';
part 'get_room_bloc.freezed.dart';

@injectable
class GetRoomBloc extends Bloc<GetRoomEvent, GetRoomState> {
  final ChatRepository _chatRepository;
  final SharedPreference _prefs;
  GetRoomBloc(this._prefs, this._chatRepository) : super(const _Initial()) {
    on<_GetRoom>((event, emit) async {
      emit(const GetRoomState.loading());
      await emit.forEach(
          _chatRepository.getRoom(_prefs.getUserAuthDetails().userId, event.recieverId),
          onData: (room) => GetRoomState.success(room),
          onError: (error, stackTrace) => GetRoomState.error(error.toString()));
    });
  }
}
