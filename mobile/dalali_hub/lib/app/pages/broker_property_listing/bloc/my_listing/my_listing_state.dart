

part of 'my_listing_bloc.dart';

@freezed
class MyListingState with _$MyListingState {
  const factory MyListingState.initial() = _Initial;
  const factory MyListingState.loading() = _Loading;
  const factory MyListingState.success(List<Feed> feeds) = _Success;
  const factory MyListingState.error(String message) = _Error;
}
