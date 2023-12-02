import mongoose, { Schema, Types } from "mongoose";
import { IBaseEntity } from "./BaseEntity";

export interface PhotoEntity extends IBaseEntity {
  secureUrl: string;
  publicId: string;
  _id: Types.ObjectId;
}

let photoSchema = new Schema<PhotoEntity>(
  {
    secureUrl: { type: String, required: [true, "Url is required"] },
    publicId: { type: String, required: [true, "Public Id is required"] },
  },
  { timestamps: true },
);

export const Photo = mongoose.model<PhotoEntity>("Photo", photoSchema);
