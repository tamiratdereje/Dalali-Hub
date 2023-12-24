import 'package:dalali_hub/data/remote/model/photo_response_dto.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';

class UserResponse {
  final String id;
  final String firstName;
  final String middleName;
  final String sirName;
  List<PhotoResponse> photos;
  final String email;
  final String phoneNumber;
  final String gender;
  
 

  UserResponse({
    required this.id,
    required this.firstName,
  required  this.middleName,
    required this.sirName,
   required this.photos,
   required this.email,
   required this.phoneNumber,
   required this.gender
  
  });
}