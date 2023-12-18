part of 'add_to_my_favorite_bloc.dart';

@freezed
class AddToMyFavoriteEvent with _$AddToMyFavoriteEvent {
  const factory AddToMyFavoriteEvent.started() = _Started;
  const factory AddToMyFavoriteEvent.addToMyFavorite(String propertyId) = _AddToMyFavorite;
}