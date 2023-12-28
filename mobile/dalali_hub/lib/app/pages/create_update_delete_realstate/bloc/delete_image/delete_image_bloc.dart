import 'package:bloc/bloc.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/domain/repository/images_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dalali_hub/util/resource.dart';
import 'package:injectable/injectable.dart';

part 'delete_image_event.dart';
part 'delete_image_state.dart';
part 'delete_image_bloc.freezed.dart';

@injectable
class DeleteImageBloc extends Bloc<DeleteImageEvent, DeleteImageState> {
  final IImagesRepository _imageRepository;

  DeleteImageBloc(this._imageRepository) : super(const _Initial()) {
    on<_DeleteImage>((event, emit) async {
      emit(const _Loading());
      var response = await _imageRepository.deletePhoto(
          event.propertyId, event.imageId, event.propertyName);
      response.fold(onSuccess: (data) {
        emit(_Success(data));
      }, onError: (error) {
        emit(_Error(error.message));
      });
    });
  }
}
