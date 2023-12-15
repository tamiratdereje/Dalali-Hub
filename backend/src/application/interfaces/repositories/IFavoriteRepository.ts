import { FavoriteEntity } from "@entities/FavoriteEntity";
import { IGenericRepository } from "./IGenericRepository";
import mongoose from "mongoose";

export interface IFavoriteRepository extends IGenericRepository<FavoriteEntity> {
  GetMyFavorites(userId: mongoose.Types.ObjectId): Promise<FavoriteEntity[]>;
}
