part of 'feeds_bloc.dart';

@freezed
class FeedsEvent with _$FeedsEvent {
  const factory FeedsEvent.started() = _Started;
  const factory FeedsEvent.feeds() = _Feeds;
}