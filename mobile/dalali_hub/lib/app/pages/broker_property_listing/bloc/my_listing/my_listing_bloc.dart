import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/repository/feed_repository.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'my_listing_event.dart';
part 'my_listing_state.dart';
part 'my_listing_bloc.freezed.dart';

@injectable
class MyListingBloc extends Bloc<MyListingEvent, MyListingState> {
  final IFeedRepository _feedRepository;

  MyListingBloc(this._feedRepository) : super(const _Initial()) {
    on<_MyListing>((event, emit) async {
      emit(const _Loading());
      var response = await _feedRepository.getMyListing(event.isApproved);
      response.fold(onSuccess: (data) {
        emit(_Success(data));
      }, onError: (error) {
        emit(_Error(error.message));
      });
    });

    on<_UpdateFavorite>((event, emit) {
      final state = this.state;
      debugPrint("Current state after adding to favorite ${state.toString()}");
      if (state is _Success) {
        // Clone the current state
        final currentState = (state as _Success);
        final updatedData = List<Feed>.from(currentState.feeds);

        // Find the index of the feed to update
        final index =
            updatedData.indexWhere((feed) => feed.id == event.propertyId);
          
        
        debugPrint("index: $index");

        if (index != -1) {
          // Update the favorite status
          updatedData[index].isFavorite = !updatedData[index].isFavorite!;
          debugPrint("updatedData[index].isFavorite: ${updatedData[index].isFavorite}");
          emit(_Success(updatedData));
        }
      }
    });
  }
}
