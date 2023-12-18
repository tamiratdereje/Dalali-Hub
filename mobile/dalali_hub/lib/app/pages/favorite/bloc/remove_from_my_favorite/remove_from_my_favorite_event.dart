part of 'remove_from_my_favorite_bloc.dart';

@freezed
class RemoveFromMyFavoriteEvent with _$RemoveFromMyFavoriteEvent {
  const factory RemoveFromMyFavoriteEvent.started() = _Started;
  const factory RemoveFromMyFavoriteEvent.removeFromMyFavorite(String propertyId) = _RemoveFromMyFavorite;
}