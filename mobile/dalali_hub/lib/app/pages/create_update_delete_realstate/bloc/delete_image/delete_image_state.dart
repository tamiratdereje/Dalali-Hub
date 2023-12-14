part of 'delete_image_bloc.dart';

@freezed
class DeleteImageState with _$DeleteImageState {
  const factory DeleteImageState.initial() = _Initial;
  const factory DeleteImageState.loading() = _Loading;
  const factory DeleteImageState.success() = _Success;
  const factory DeleteImageState.error(String message) = _Error;
}
