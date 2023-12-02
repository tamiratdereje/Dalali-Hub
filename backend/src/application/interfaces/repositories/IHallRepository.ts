import { HallEntity } from "@entities/HallEntity";
import { IGenericRepository } from "./IGenericRepository";

export interface IHallRepository extends IGenericRepository<HallEntity> {
  GetByFilter(filter: {}): Promise<HallEntity[]>;
  CreateHall(house: HallEntity): Promise<HallEntity>;

}
