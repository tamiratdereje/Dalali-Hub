part of 'set_messages_seen_bloc.dart';


@freezed
class SetMessagesSeenState with _$SetMessagesSeenState {
  const factory SetMessagesSeenState.initial() = _Initial;
  const factory SetMessagesSeenState.loading() = _Loading;
  const factory SetMessagesSeenState.success() = _Success;
  const factory SetMessagesSeenState.error(String message) = _Error;
}
