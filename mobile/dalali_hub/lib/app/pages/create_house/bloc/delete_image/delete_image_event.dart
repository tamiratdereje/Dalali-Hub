part of 'delete_image_bloc.dart';

@freezed
class DeleteImageEvent with _$DeleteImageEvent {
  const factory DeleteImageEvent.started() = _Started;
  const factory DeleteImageEvent.deleteImage({
    required String imageId,
    required String propertyId
  }) = _DeleteImage;
}