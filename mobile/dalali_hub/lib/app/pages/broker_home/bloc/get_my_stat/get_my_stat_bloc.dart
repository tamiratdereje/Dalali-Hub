import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/broker_stats.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/repository/feed_repository.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'get_my_stat_event.dart';
part 'get_my_stat_state.dart';
part 'get_my_stat_bloc.freezed.dart';

@injectable
class GetMyStatBloc
    extends Bloc<GetMyStatEvent, GetMyStatState> {
      final IFeedRepository _feedRepository;
  GetMyStatBloc(this._feedRepository) : super(const _Initial()) {
    
    on<_GetMyStat>((event, emit) async {
      emit(const _Loading());
      var response = await _feedRepository.getMyStat();
      response.fold(onSuccess: (data) {
        emit(_Success(data));
      }, onError: (error) {
        emit(_Error(error.message));
      });
    });
    
  }
}
