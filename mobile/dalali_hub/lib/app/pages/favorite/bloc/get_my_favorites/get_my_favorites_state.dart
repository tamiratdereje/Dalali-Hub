

part of 'get_my_favorites_bloc.dart';

@freezed
class GetMyFavoritesState with _$GetMyFavoritesState {
  const factory GetMyFavoritesState.initial() = _Initial;
  const factory GetMyFavoritesState.loading() = _Loading;
  const factory GetMyFavoritesState.success(List<Feed> feeds) = _Success;
  const factory GetMyFavoritesState.error(String message) = _Error;
}
