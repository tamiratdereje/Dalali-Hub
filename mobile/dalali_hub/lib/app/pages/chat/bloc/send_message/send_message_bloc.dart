import 'package:bloc/bloc.dart';
import 'package:dalali_hub/data/remote/model/realm/realm_models.dart';
import 'package:dalali_hub/domain/repository/chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'send_message_event.dart';
part 'send_message_state.dart';
part 'send_message_bloc.freezed.dart';

@injectable
class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  final ChatRepository _chatRepository;
  SendMessageBloc(this._chatRepository) : super(const _Initial()) {
    on<_SendMessage>((event, emit) async {
      emit(const SendMessageState.loading());
      await emit.forEach(
        _chatRepository.sendMessage(event.message, event.roomId),
        onData: (value) => const _Success(),
        onError: (error, stackTrace) =>
            SendMessageState.error(error.toString()),
      );
    });
  }
}
