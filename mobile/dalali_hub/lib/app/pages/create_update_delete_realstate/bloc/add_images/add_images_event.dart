part of 'add_images_bloc.dart';

@freezed
class AddImagesEvent with _$AddImagesEvent {
  const factory AddImagesEvent.started() = _Started;
  const factory AddImagesEvent.addImages({
    required List<String> images,
    required String propertyId,
  }) = _AddImages;
}