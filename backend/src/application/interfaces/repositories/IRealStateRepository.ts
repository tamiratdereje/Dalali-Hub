import { RealStateEntity } from "@entities/RealStateEntity";
import { IGenericRepository } from "./IGenericRepository";

export interface IRealStateRepository extends IGenericRepository<RealStateEntity> {
  GetByFilter(filter: {}, populate: string): Promise<RealStateEntity[]>;
  CreateRealState(realState: RealStateEntity): Promise<RealStateEntity>;
}
