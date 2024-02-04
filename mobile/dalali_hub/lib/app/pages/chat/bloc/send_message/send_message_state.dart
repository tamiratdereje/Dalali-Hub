part of 'send_message_bloc.dart';

@immutable
sealed class SendMessageState {}

final class SendMessageInitial extends SendMessageState {}
