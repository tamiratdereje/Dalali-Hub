

part of 'add_to_my_favorite_bloc.dart';

@freezed
class AddToMyFavoriteState with _$AddToMyFavoriteState {
  const factory AddToMyFavoriteState.initial() = _Initial;
  const factory AddToMyFavoriteState.loading() = _Loading;
  const factory AddToMyFavoriteState.success(Feed feed) = _Success;
  const factory AddToMyFavoriteState.error(String message) = _Error;
}
