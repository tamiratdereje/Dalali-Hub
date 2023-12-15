import 'package:dalali_hub/domain/entity/filter_parameter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'filter_parameter_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class FilterParameterDto {
  String? region;
  String? district;
  String? ward;
  int? lowerRooms;
  int? upperRooms;
  int? lowerSeats;
  int? upperSeats;
  double? widthSize;
  double? heightSize;
  double? lowerPrice;
  double? upperPrice;
  String? currency;
  String? make;
  int? minYears;
  int? maxYears;
  String? category;

  FilterParameterDto(
      {this.region,
      this.district,
      this.ward,
      this.lowerRooms,
      this.upperRooms,
      this.lowerSeats,
      this.upperSeats,
      this.widthSize,
      this.heightSize,
      this.lowerPrice,
      this.upperPrice,
      this.currency,
      this.make,
      this.minYears,
      this.maxYears,
      this.category});
  factory FilterParameterDto.fromJson(Map<String, dynamic> json) =>
      _$FilterParameterDtoFromJson(json);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['region'] = region;
    data['district'] = district;
    data['ward'] = ward;
    data['rooms'] = {'lt': upperRooms, 'gt': lowerRooms};
    data['seats'] = {'lt': upperSeats, 'gt': lowerSeats};
    data['widthSize'] = {'lt': widthSize};
    data['heightSize'] = {'lt': heightSize};
    data['price'] = {'lt': upperPrice, 'gt': lowerPrice};
    data['currency'] = currency;
    data['make'] = make;
    data['years'] = {'lt': maxYears, 'gt': minYears};
    data['category'] = category;
    return data;
  }

  static FilterParameterDto toFilterParameterDto(
      FilterParameter filterParameter) {
    return FilterParameterDto(
        region: filterParameter.region,
        district: filterParameter.district,
        ward: filterParameter.ward,
        lowerRooms: filterParameter.lowerRooms,
        upperRooms: filterParameter.upperRooms,
        lowerSeats: filterParameter.lowerSeats,
        upperSeats: filterParameter.upperSeats,
        widthSize: filterParameter.widthSize,
        heightSize: filterParameter.heightSize,
        lowerPrice: filterParameter.lowerPrice,
        upperPrice: filterParameter.upperPrice,
        currency: filterParameter.currency,
        make: filterParameter.make,
        minYears: filterParameter.minYears,
        maxYears: filterParameter.maxYears,
        category: filterParameter.category);
  }
}
