import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'send_message_event.dart';
part 'send_message_state.dart';

class SendMessageBloc extends Bloc<SendMessageEvent, SendMessageState> {
  SendMessageBloc() : super(SendMessageInitial()) {
    on<SendMessageEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
