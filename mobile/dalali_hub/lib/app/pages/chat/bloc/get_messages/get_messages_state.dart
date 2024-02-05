part of 'get_messages_bloc.dart';


@freezed
class GetMessagesState with _$GetMessagesState {
  const factory GetMessagesState.initial() = _Initial;
  const factory GetMessagesState.loading() = _Loading;
  const factory GetMessagesState.success(List<Messages> messages) = _Success;
  const factory GetMessagesState.error(String message) = _Error;
}
