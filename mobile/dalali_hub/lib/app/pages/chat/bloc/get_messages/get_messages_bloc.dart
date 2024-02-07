import 'package:bloc/bloc.dart';
import 'package:dalali_hub/data/remote/model/realm/realm_models.dart';
import 'package:dalali_hub/domain/repository/chat_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'get_messages_event.dart';
part 'get_messages_state.dart';
part 'get_messages_bloc.freezed.dart';

@injectable
class GetMessagesBloc extends Bloc<GetMessagesEvent, GetMessagesState> {
  final ChatRepository _chatRepository;
  GetMessagesBloc(this._chatRepository) : super(const _Initial()) {
    on<_GetMessages>((event, emit) async {
      emit(const GetMessagesState.loading());
      await emit.forEach(_chatRepository.getMessages(event.roomId),
          onData: (messages) {
            // if there are unseen messages, set them to seen
            
            emit(const GetMessagesState.loading());
            return GetMessagesState.success(messages);
          },
          onError: (error, stackTrace) =>
              GetMessagesState.error(error.toString()));
    });
  }
}
