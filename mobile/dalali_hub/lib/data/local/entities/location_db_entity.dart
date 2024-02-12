import 'package:floor/floor.dart';

@Entity(tableName: "LocationEntity")
class LocationEntity {
  @PrimaryKey(autoGenerate: true)
  final String region;
  final String district;
  final String ward;

  LocationEntity({
    required this.region,
    required this.district,
    required this.ward,
  });
}
