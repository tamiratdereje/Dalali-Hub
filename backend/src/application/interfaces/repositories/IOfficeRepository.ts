import { OfficeEntity } from "@entities/OfficeEntity";
import { IGenericRepository } from "./IGenericRepository";

export interface IOfficeRepository extends IGenericRepository<OfficeEntity> {
  GetByFilter(filter: {}): Promise<OfficeEntity[]>;
  CreateOffice(house: OfficeEntity): Promise<OfficeEntity>;

}
