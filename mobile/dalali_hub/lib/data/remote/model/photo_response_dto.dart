
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_response_dto.g.dart';

@JsonSerializable()
class PhotoResponseDto {
  final String id;
  final String publicUrl;
  final String secoureUrl;

  PhotoResponseDto({
    required this.id,
    required this.publicUrl,
    required this.secoureUrl,
  });
  factory PhotoResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PhotoResponseDtoFromJson(json);

  PhotoResponse toPhotoResponse() => PhotoResponse(
        id: id,
        publicUrl: publicUrl,
        secoureUrl: secoureUrl,
      );

}