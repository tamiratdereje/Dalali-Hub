import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/repository/chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'set_messages_seen_event.dart';
part 'set_messages_seen_state.dart';
part 'set_messages_seen_bloc.freezed.dart';

@injectable
class SetMessagesSeenBloc
    extends Bloc<SetMessagesSeenEvent, SetMessagesSeenState> {
  final ChatRepository _chatRepository;
  SetMessagesSeenBloc(this._chatRepository) : super(const _Initial()) {
    on<_SetMessagesSeenEvent>((event, emit) {
      emit(const SetMessagesSeenState.loading());
      _chatRepository.setMessagesSeen(event.roomId).listen((value) {
        emit(const SetMessagesSeenState.success());
      }).onError((error) {
        emit(SetMessagesSeenState.error(error.toString()));
      });
    });
  }
}
