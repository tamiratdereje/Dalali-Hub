
class FilterParameter {
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

  FilterParameter({
    this.region,
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
    this.category
  });
}
