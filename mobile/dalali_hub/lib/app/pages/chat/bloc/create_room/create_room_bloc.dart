import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'create_room_event.dart';
part 'create_room_state.dart';

class CreateRoomBloc extends Bloc<CreateRoomEvent, CreateRoomState> {
  CreateRoomBloc() : super(CreateRoomInitial()) {
    on<CreateRoomEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
