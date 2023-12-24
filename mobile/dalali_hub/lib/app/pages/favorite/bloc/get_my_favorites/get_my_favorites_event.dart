part of 'get_my_favorites_bloc.dart';

@freezed
class GetMyFavoritesEvent with _$GetMyFavoritesEvent {
  const factory GetMyFavoritesEvent.started() = _Started;
  const factory GetMyFavoritesEvent.getMyFavorites() = _GetMyFavorites;
  const factory GetMyFavoritesEvent.updateFavorite(Feed property) =
      _UpdateFavorite;
}
