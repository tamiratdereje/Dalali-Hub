import { VehicleEntity } from "@entities/VehicleEntity";
import { IGenericRepository } from "./IGenericRepository";

export interface IVehicleRepository extends IGenericRepository<VehicleEntity> {
  GetByFilter(filter: {}, populate: string): Promise<VehicleEntity[]>;
  CreateVehicle(vehicle: VehicleEntity): Promise<VehicleEntity>;
}
