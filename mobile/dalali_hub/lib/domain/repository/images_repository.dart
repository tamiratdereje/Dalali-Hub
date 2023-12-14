import 'package:dalali_hub/domain/entity/empty.dart';
import 'package:dalali_hub/domain/entity/photo_response.dart';
import 'package:dalali_hub/util/resource.dart';

abstract class IImagesRepository {
 
  Future<Resource<Empty>> deletePhoto(String propertyId, String photoId);
  Future<Resource<PhotoResponse>> addPhotos(
      String propertyId, List<String> photos);
  Future<Resource<PhotoResponse>> getPhotos(String propertyId);
}
