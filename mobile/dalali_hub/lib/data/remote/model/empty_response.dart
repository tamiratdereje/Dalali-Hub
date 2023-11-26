import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'empty_response.g.dart';

@JsonSerializable()
class EmptyResponse {
  EmptyResponse();

  factory EmptyResponse.fromJson(Map<String, dynamic> json) =>
      _$EmptyResponseFromJson(json);
  
  Map<String, dynamic> toJson() => _$EmptyResponseToJson(this);

  Empty toDomain() => const Empty();
  factory EmptyResponse.fromDomain(Empty empty) => EmptyResponse();
}