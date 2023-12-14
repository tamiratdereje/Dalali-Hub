import { VehicleEntity } from "@entities/VehicleEntity";
import { GenericRepository } from "./GenericRepository";
import mongoose from "mongoose";
import { IVehicleRepository } from "@interfaces/repositories/IVehicleRepository";

export class VehicleRepository extends
 GenericRepository<VehicleEntity> implements IVehicleRepository {
  constructor(private schema: mongoose.Model<VehicleEntity>) {
    super(schema);
  }
  async GetByFilter(filter: {}): Promise<VehicleEntity[]> {
    const vehicleEntity = (await this._schema.find(filter));
    return vehicleEntity
  }
  async CreateVehicle(vehicle: VehicleEntity): Promise<VehicleEntity> {
    const entityCreate = (await this._schema.create(vehicle)).populate("photos");
    return entityCreate;
  }
}