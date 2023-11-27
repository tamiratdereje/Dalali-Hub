import { HouseEntity } from "@entities/HouseEntity";
import { IGenericRepository } from "./IGenericRepository";

export interface IHouseRepository extends IGenericRepository<HouseEntity> {
  GetByFilter(filter: {}): Promise<HouseEntity[]>;
}
