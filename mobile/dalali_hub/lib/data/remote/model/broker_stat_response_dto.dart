import 'package:dalali_hub/domain/entity/broker_stats.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'broker_stat_response_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class BrokerStatResponseDto {
  int totalNumOfView;
  int totalListing;
  int numberOfFavorite;
  int numberOfSuccedListing;

  BrokerStatResponseDto({
    required this.totalListing,
    required this.numberOfSuccedListing,
    required this.totalNumOfView,
    required this.numberOfFavorite,
  });

  factory BrokerStatResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BrokerStatResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$BrokerStatResponseDtoToJson(this);

  BrokerStat toBrokerStat() {
    return BrokerStat(
      totalListing: totalListing,
      totalNumOfView: totalNumOfView,
      numberOfFavorite: numberOfFavorite,
      numberOfSuccedListing: numberOfSuccedListing
    );
  } 
}
