import { HouseEntity } from "@entities/HouseEntity";
import { GenericRepository } from "./GenericRepository";
import mongoose from "mongoose";
import { IHouseRepository } from "@interfaces/repositories/IHouseRepository";

export class HouseRepository extends
 GenericRepository<HouseEntity> implements IHouseRepository {
  constructor(private schema: mongoose.Model<HouseEntity>) {
    super(schema);
  }
   async GetByFilter(filter: {}): Promise<HouseEntity[]> {
        const houseEntities = await this._schema.find(filter);
        return houseEntities;
    }
}
