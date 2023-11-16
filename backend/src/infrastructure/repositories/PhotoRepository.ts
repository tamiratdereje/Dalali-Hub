import { PhotoEntity } from "@entities/PhotoEntity";
import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { GenericRepository } from "./GenericRepository";

export class PhotoRepository
  extends GenericRepository<PhotoEntity>
  implements IPhotoRepository {}
