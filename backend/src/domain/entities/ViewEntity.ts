import { RealStateCategory } from "domain/types/types";
import mongoose, { Schema, Types } from "mongoose";
import { IBaseEntity } from "./BaseEntity";

export interface ViewEntity extends IBaseEntity {
  _id: Types.ObjectId;
  property: mongoose.Types.ObjectId;
  user: mongoose.Types.ObjectId;
  model_type: String;
}

let viewSchema = new Schema<ViewEntity>(
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

export const View = mongoose.model<ViewEntity>(
  "View",
  viewSchema
);
