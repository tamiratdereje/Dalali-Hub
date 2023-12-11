import { RealStateEntity } from "@entities/RealStateEntity";
import { GenericRepository } from "./GenericRepository";
import mongoose from "mongoose";
import { IRealStateRepository } from "@interfaces/repositories/IRealStateRepository";

export class RealStateRepository extends
 GenericRepository<RealStateEntity> implements IRealStateRepository {
  constructor(private schema: mongoose.Model<RealStateEntity>) {
    super(schema);
  }
  async GetByFilter(filter: {}): Promise<RealStateEntity[]> {
    const realStateEntity = (await this._schema.find(filter));
    return realStateEntity
  }
  async CreateRealState(realState: RealStateEntity): Promise<RealStateEntity> {
    const entityCreate = (await this._schema.create(realState)).populate("photos");
    return entityCreate;
  }
}