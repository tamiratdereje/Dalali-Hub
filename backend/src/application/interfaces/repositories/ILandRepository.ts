import { LandEntity } from "@entities/LandEntity";
import { IGenericRepository } from "./IGenericRepository";

export interface ILandRepository extends IGenericRepository<LandEntity> {
  GetByFilter(filter: {}): Promise<LandEntity[]>;
}
