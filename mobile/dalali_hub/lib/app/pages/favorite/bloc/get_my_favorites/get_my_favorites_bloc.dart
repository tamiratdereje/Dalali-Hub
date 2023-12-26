import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/repository/favorite_repository.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'get_my_favorites_event.dart';
part 'get_my_favorites_state.dart';
part 'get_my_favorites_bloc.freezed.dart';

@injectable
class GetMyFavoritesBloc
    extends Bloc<GetMyFavoritesEvent, GetMyFavoritesState> {
  final IFavoriteRepository _getMyFavoriteRepository;
  late final StreamSubscription favoriteStream;

  GetMyFavoritesBloc(this._getMyFavoriteRepository) : super(const _Initial()) {
    favoriteStream = _getMyFavoriteRepository.favorite.listen(
      (event) {
        debugPrint("Favorite to be added ${event.toString()}");
        if (event != null) {
          add(GetMyFavoritesEvent.updateFavorite(event));
        }
      },
    );
    on<_GetMyFavorites>((event, emit) async {
      emit(const _Loading());
      var response = await _getMyFavoriteRepository.getMyFavorites();
      response.fold(onSuccess: (data) {
        emit(_Success(data));
      }, onError: (error) {
        emit(_Error(error.message));
      });
    });
    on<_UpdateFavorite>((event, emit) {
      final state = this.state;
      if (state is _Success) {
        // Clone the current state
        final currentState = state;
        List<Feed> favorites = [];
        favorites.addAll(currentState.feeds);
        int index = -1;
        //  iterate over favorites and get index of the property
        for (int i = 0; i < favorites.length; i++) {
          if (favorites[i].id == event.property.id) {
            index = i;
            break;
          }
        }

        if (index != -1) {
          favorites.removeAt(index);
        } else {
          favorites.add(event.property);
        }

        // Update the favorite status

        emit(_Success(favorites));
      }
    });
  }

  @override
  Future<void> close() {
    debugPrint("Closing Get my favorites");
    favoriteStream.cancel();
    return super.close();
  }
}
