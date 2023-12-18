

part of 'remove_from_my_favorite_bloc.dart';

@freezed
class RemoveFromMyFavoriteState with _$RemoveFromMyFavoriteState {
  const factory RemoveFromMyFavoriteState.initial() = _Initial;
  const factory RemoveFromMyFavoriteState.loading() = _Loading;
  const factory RemoveFromMyFavoriteState.success() = _Success;
  const factory RemoveFromMyFavoriteState.error(String message) = _Error;
}
