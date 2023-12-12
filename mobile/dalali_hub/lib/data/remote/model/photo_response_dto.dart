
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_response_dto.g.dart';

@JsonSerializable()
class PhotoResponseDto {
  final String id;
  final String publicId;
  final String secureUrl;

  PhotoResponseDto({
    required this.id,
    required this.publicId,
    required this.secureUrl,
  });
  factory PhotoResponseDto.fromJson(Map<String, dynamic> json) =>
      _$PhotoResponseDtoFromJson(json);

  PhotoResponse toPhotoResponse() => PhotoResponse(
        id: id,
        publicUrl: publicId,
        secoureUrl: secureUrl,
      );

  toJson() {}

}