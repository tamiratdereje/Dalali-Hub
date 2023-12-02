import { HouseEntity } from "@entities/HouseEntity";
import { GenericRepository } from "./GenericRepository";
import mongoose from "mongoose";
import { IHallRepository } from "@interfaces/repositories/IHallRepository";
import { HallEntity } from "@entities/HallEntity";

export class HallRepository
  extends GenericRepository<HallEntity>
  implements IHallRepository
{
  constructor(private schema: mongoose.Model<HallEntity>) {
    super(schema);
  }
  async CreateHall(house: HallEntity): Promise<HallEntity> {
    const entityCreate = (await this._schema.create(house)).populate("photos");
    return entityCreate;
  }
  async GetByFilter(filter: {}): Promise<HallEntity[]> {
    const hallEntities = await this._schema.find(filter);
    return hallEntities;
  }
}
