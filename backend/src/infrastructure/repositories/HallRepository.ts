import { HouseEntity } from "@entities/HouseEntity";
import { GenericRepository } from "./GenericRepository";
import mongoose from "mongoose";
import { IHallRepository } from "@interfaces/repositories/IHallRepository";
import { HallEntity } from "@entities/HallEntity";

export class HallRepository extends
 GenericRepository<HallEntity> implements IHallRepository {
  constructor(private schema: mongoose.Model<HallEntity>) {
    super(schema);
  }
   async GetByFilter(filter: {}): Promise<HallEntity[]> {
        const hallEntities = await this._schema.find(filter);
        return hallEntities;
    }
}
