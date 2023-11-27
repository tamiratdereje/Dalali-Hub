import mongoose, { Schema, Types } from "mongoose";
import { IBaseEntity } from "./BaseEntity";

export interface RegionEntity extends IBaseEntity {
  _id: Types.ObjectId;
  region: String;
  district: String;
  ward: String;
}

let regionSchema = new Schema<RegionEntity>(
  {
    _id: { type: Schema.Types.ObjectId, auto: true },
    region: { type: String, required: [true, "Region is required"] },
    district: { type: String, required: [true, "District is required"] },
    ward: { type: String, required: [true, "Ward is required"] },

    
  },
  { timestamps: true }
);

export const Region = mongoose.model<RegionEntity>("Region", regionSchema);
