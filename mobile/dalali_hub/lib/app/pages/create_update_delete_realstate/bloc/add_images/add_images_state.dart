part of 'add_images_bloc.dart';

@freezed
class AddImagesState with _$AddImagesState {
  const factory AddImagesState.initial() = _Initial;
  const factory AddImagesState.loading() = _Loading;
  const factory AddImagesState.success() = _Success;
  const factory AddImagesState.error(String message) = _Error;
}
