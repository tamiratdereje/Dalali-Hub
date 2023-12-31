import { FavoriteEntity } from "@entities/FavoriteEntity";
import { IGenericRepository } from "./IGenericRepository";
import mongoose from "mongoose";
import { ViewEntity } from "@entities/ViewEntity";

export interface IViewRepository extends IGenericRepository<ViewEntity> {
  GetMyView(user: mongoose.Types.ObjectId, property: mongoose.Types.ObjectId): Promise<ViewEntity>;
}
