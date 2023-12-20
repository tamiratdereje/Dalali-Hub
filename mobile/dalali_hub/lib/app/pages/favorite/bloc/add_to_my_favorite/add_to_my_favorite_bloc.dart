import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/feed.dart';
import 'package:dalali_hub/domain/repository/favorite_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'add_to_my_favorite_event.dart';
part 'add_to_my_favorite_state.dart';
part 'add_to_my_favorite_bloc.freezed.dart';

@injectable
class AddToMyFavoriteBloc extends Bloc<AddToMyFavoriteEvent, AddToMyFavoriteState> {
  final IFavoriteRepository _favoriteRepository;

  AddToMyFavoriteBloc(this._favoriteRepository) : super(const _Initial()) {
    on<_AddToMyFavorite>((event, emit) async {
      emit(const _Loading());
      var response = await _favoriteRepository.addToMyFavorite(event.propertyId);
      response.fold(onSuccess: (data) {
        emit(const _Success());
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
