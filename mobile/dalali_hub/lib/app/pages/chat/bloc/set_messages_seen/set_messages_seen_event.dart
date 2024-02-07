part of 'set_messages_seen_bloc.dart';

@freezed
class SetMessagesSeenEvent with _$SetMessagesSeenEvent {
  const factory SetMessagesSeenEvent.started() = _Started;
  const factory SetMessagesSeenEvent.setMessagesSeen(String roomId) = _SetMessagesSeenEvent;
}
