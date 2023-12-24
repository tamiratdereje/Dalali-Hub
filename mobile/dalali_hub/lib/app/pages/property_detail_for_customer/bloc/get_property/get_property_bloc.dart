import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/repository/feed_repository.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'get_property_event.dart';
part 'get_property_state.dart';
part 'get_property_bloc.freezed.dart';

@injectable
class GetPropertyBloc extends Bloc<GetPropertyEvent, GetPropertyState> {
  final IFeedRepository _feedRepository;

  GetPropertyBloc(this._feedRepository) : super(const _Initial()) {
    on<_GetProperty>((event, emit) async {
      emit(const _Loading());
      var response = await _feedRepository.getProperty(event.id);
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
        final currentState = state;
        final updatedData = currentState.feed;
        // Update the favorite status
        updatedData.isFavorite = !updatedData.isFavorite!;
        debugPrint("updatedData[index].isFavorite: ${updatedData.isFavorite}");
        emit(_Success(updatedData));
      }
    });
  }
}
