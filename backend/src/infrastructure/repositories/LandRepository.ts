import { LandEntity } from "@entities/LandEntity";
import { GenericRepository } from "./GenericRepository";
import mongoose from "mongoose";
import { ILandRepository } from "@interfaces/repositories/ILandRepository";

export class LandRepository extends
 GenericRepository<LandEntity> implements ILandRepository {
  constructor(private schema: mongoose.Model<LandEntity>) {
    super(schema);
  }
   async GetByFilter(filter: {}): Promise<LandEntity[]> {
        const landEntities = await this._schema.find(filter);
        return landEntities;
    }
}
