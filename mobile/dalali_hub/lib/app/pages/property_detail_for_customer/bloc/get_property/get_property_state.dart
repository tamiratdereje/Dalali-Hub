

part of 'get_property_bloc.dart';

@freezed
class GetPropertyState with _$GetPropertyState {
  const factory GetPropertyState.initial() = _Initial;
  const factory GetPropertyState.loading() = _Loading;
  const factory GetPropertyState.success(Feed feed) = _Success;
  const factory GetPropertyState.error(String message) = _Error;
}
