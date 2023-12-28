import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IImagesRepository {
 
  Future<Resource<PhotoResponse>> deletePhoto(String propertyId, String photoId, String propertyName);
  Future<Resource<List<PhotoResponse>>> addPhotos(
      String propertyId, List<String> photos,  String propertyName);
  Future<Resource<PhotoResponse>> getPhotos(String propertyId, String propertyName);
}
