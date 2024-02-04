import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'get_messages_event.dart';
part 'get_messages_state.dart';

class GetMessagesBloc extends Bloc<GetMessagesEvent, GetMessagesState> {
  GetMessagesBloc() : super(GetMessagesInitial()) {
    on<GetMessagesEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
