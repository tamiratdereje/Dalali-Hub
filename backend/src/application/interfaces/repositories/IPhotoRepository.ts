import { PhotoEntity } from "@entities/PhotoEntity";
import { IGenericRepository } from "./IGenericRepository";

export interface IPhotoRepository extends IGenericRepository<PhotoEntity> {}
