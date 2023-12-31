import mongoose from "mongoose";
import { ViewEntity } from "@entities/ViewEntity";
import { GenericRepository } from "./GenericRepository";
import { IViewRepository } from "@interfaces/repositories/IViewRepository";

export class ViewRepository
  extends GenericRepository<ViewEntity>
  implements IViewRepository
{
  constructor(private schema: mongoose.Model<ViewEntity>) {
    super(schema);
  }
  async GetMyView(
    user: mongoose.Types.ObjectId,
    property: mongoose.Types.ObjectId
  ): Promise<ViewEntity> {
    const view = await this._schema.findOne({
      user: user,
      property: property,
    });
    return view;
  }
}
