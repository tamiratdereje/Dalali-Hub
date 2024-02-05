part of 'send_message_bloc.dart';

@freezed
class SendMessageEvent with _$SendMessageEvent {
  const factory SendMessageEvent.started() = _Started;
  const factory SendMessageEvent.sendMessage(String roomId, String message) = _SendMessage;
}
