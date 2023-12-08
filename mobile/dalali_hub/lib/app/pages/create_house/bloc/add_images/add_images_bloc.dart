import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/repository/images_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'add_images_event.dart';
part 'add_images_state.dart';
part 'add_images_bloc.freezed.dart';

@injectable
class AddImagesBloc extends Bloc<AddImagesEvent, AddImagesState> {
  final IImagesRepository _imagesRepository;

  AddImagesBloc(this._imagesRepository) : super(const _Initial()) {
    on<_AddImages>((event, emit) async {
      emit(const _Loading());
      var response = await _imagesRepository.addPhotos(event.propertyId, event.images);
      response.fold(onSuccess: (data) {
        emit(const _Success());
        
      }, onError: (error) {
          emit(_Error(error.message));
      
      });
    });
  }
}
