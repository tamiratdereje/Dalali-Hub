import { OfficeEntity } from "@entities/OfficeEntity";
import { GenericRepository } from "./GenericRepository";
import mongoose from "mongoose";
import { IOfficeRepository } from "@interfaces/repositories/IOfficeRepository";

export class OfficeRepository
  extends GenericRepository<OfficeEntity>
  implements IOfficeRepository
{
  constructor(private schema: mongoose.Model<OfficeEntity>) {
    super(schema);
  }
  async CreateOffice(house: OfficeEntity): Promise<OfficeEntity> {
    const entityCreate = (await this._schema.create(house)).populate("photos");
    return entityCreate;
  }
  async GetByFilter(filter: {}): Promise<OfficeEntity[]> {
    const officeEntities = await this._schema.find(filter);
    return officeEntities;
  }
}
