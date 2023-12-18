import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/repository/favorite_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'remove_from_my_favorite_event.dart';
part 'remove_from_my_favorite_state.dart';
part 'remove_from_my_favorite_bloc.freezed.dart';

@injectable
class RemoveFromMyFavoriteBloc extends Bloc<RemoveFromMyFavoriteEvent, RemoveFromMyFavoriteState> {
  final IFavoriteRepository _favoriteRepository;

  RemoveFromMyFavoriteBloc(this._favoriteRepository) : super(const _Initial()) {
    on<_RemoveFromMyFavorite>((event, emit) async {
      emit(const _Loading());
      var response = await _favoriteRepository.removeFromMyFavorite(event.propertyId);
      response.fold(onSuccess: (data) {
        emit(_Success());
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
