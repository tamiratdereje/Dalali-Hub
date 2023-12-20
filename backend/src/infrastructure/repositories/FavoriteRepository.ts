import mongoose from "mongoose";
import { IFavoriteRepository } from "@interfaces/repositories/IFavoriteRepository";
import { FavoriteEntity } from "@entities/FavoriteEntity";
import { GenericRepository } from "./GenericRepository";

export class FavoriteRepository
  extends GenericRepository<FavoriteEntity>
  implements IFavoriteRepository
{
  constructor(private schema: mongoose.Model<FavoriteEntity>) {
    super(schema);
  }
 async GetMyFavorite(user: mongoose.Types.ObjectId, property: mongoose.Types.ObjectId): Promise<FavoriteEntity> {
    const favorite = await this._schema.findOne({ user: user, property: property });
    return favorite;
  }
  async GetMyFavorites(
    userId: mongoose.Types.ObjectId
  ): Promise<FavoriteEntity[]> {
    const favorites = await this._schema.find({ user: userId });
    return favorites;
  }
}
