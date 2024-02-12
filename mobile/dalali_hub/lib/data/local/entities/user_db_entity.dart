import 'package:dalali_hub/data/local/entities/photo_db_entity.dart';
import 'package:floor/floor.dart';

@Entity(tableName: 'UserEntity', foreignKeys: [
  ForeignKey(
      childColumns: ['photo'], parentColumns: ['id'], entity: PhotoEntity)
])
class UserEntity {
  @PrimaryKey(autoGenerate: false)
  final String id;
  final String firstName;
  final String middleName;
  final String sirName;
  @ColumnInfo(name: "photo")
  final String photo;
  final String email;
  final String phoneNumber;
  final String gender;

  UserEntity(
      {required this.id,
      required this.firstName,
      required this.middleName,
      required this.sirName,
      required this.photo,
      required this.email,
      required this.phoneNumber,
      required this.gender});
}
