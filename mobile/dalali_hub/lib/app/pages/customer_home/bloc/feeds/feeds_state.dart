

part of 'feeds_bloc.dart';

@freezed
class FeedsState with _$FeedsState {
  const factory FeedsState.initial() = _Initial;
  const factory FeedsState.loading() = _Loading;
  const factory FeedsState.success(List<Feed> feeds) = _Success;
  const factory FeedsState.error(String message) = _Error;
}
