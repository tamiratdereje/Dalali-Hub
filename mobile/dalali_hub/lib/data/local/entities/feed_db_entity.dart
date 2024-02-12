import 'package:dalali_hub/data/local/entities/location_db_entity.dart';
import 'package:dalali_hub/data/local/entities/user_db_entity.dart';
import 'package:floor/floor.dart';

@Entity(tableName: "FeedEntity", foreignKeys: [
  ForeignKey(
      childColumns: ['locationId'],
      parentColumns: ['id'],
      entity: LocationEntity),
  ForeignKey(childColumns: ['owner'], parentColumns: ['id'], entity: UserEntity)
])
class FeedEntity {
  @PrimaryKey(autoGenerate: false)
  final String id;
  final String? title;
  final String photos;

  final double? rooms;
  final double? beds;
  final double? baths;
  final double? kitchens;
  final int? seats;

  final double? sizeWidth;
  final double? sizeHeight;
  final String? sizeUnit;
  final String? otherFeatures;
  final String? description;
  final bool? isApproved;
  final String? category;
  final int? locationId;

  final String? make;
  final String? model;
  final int? year;

  final String? color;
  final String? vin;
  final String? fuelType;
  final int? engineSize;
  final String? transmissionType;
  final double? mileage;
  final double? price;
  final String? condition;

  @ColumnInfo(name: "owner")
  final String owner;
  final int numberOfViews;
  bool? isFavorite;

  FeedEntity({
    required this.id,
    this.title,
    this.category,
    required this.photos,
    this.rooms,
    this.beds,
    this.baths,
    this.kitchens,
    this.seats,
    this.sizeWidth,
    this.sizeHeight,
    this.sizeUnit,
    this.otherFeatures,
    this.description,
    this.isApproved,
    required this.locationId,
    this.make,
    this.model,
    this.year,
    this.color,
    this.vin,
    this.fuelType,
    this.engineSize,
    this.transmissionType,
    this.mileage,
    this.price,
    this.condition,
    required this.owner,
    required this.numberOfViews,
    this.isFavorite,
  });
}
