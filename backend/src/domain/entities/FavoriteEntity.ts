import { RealStateCategory } from "domain/types/types";
import mongoose, { Schema, Types } from "mongoose";
import { IBaseEntity } from "./BaseEntity";

export interface FavoriteEntity extends IBaseEntity {
  _id: Types.ObjectId;
  property: mongoose.Types.ObjectId;
  user: mongoose.Types.ObjectId;
  model_type: String;
}

let favoriteSchema = new Schema<FavoriteEntity>(
  {
    _id: { type: Schema.Types.ObjectId, auto: true },
    property: { type: Schema.Types.ObjectId, refPath: "model_type" },
    model_type: {
      type: String,
      enum: ["RealState", "Vehicle"],
    },
    user: { type: Schema.Types.ObjectId, ref: "User" },
  },
  { timestamps: true }
);

export const Favorite = mongoose.model<FavoriteEntity>(
  "Favorite",
  favoriteSchema
);
