import 'package:floor/floor.dart';


@Entity(tableName: "PhotoEntity")
class PhotoEntity {
  @PrimaryKey(autoGenerate: false)
  final String id;
  final String publicUrl;
  final String secoureUrl;
  PhotoEntity({
    required this.id,
    required this.publicUrl,
    required this.secoureUrl,
  });
}
