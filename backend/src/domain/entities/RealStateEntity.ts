import { RealStateCategory, Status } from "domain/types/types";
import mongoose, { Schema, Types } from "mongoose";
import { IBaseEntity } from "./BaseEntity";

export interface RealStateEntity extends IBaseEntity {
  _id: Types.ObjectId;
  title: String;
  photos: mongoose.Types.ObjectId[];
  price: Number;
  category: RealStateCategory;
  owner: mongoose.Types.ObjectId;

  rooms: Number | null;
  beds: Number | null;
  baths: Number | null;
  kitchens: Number | null;
  seats: Number | null;

  sizeWidth: Number;
  sizeHeight: Number;
  sizeUnit: String;
  location: { region: String; district: String; ward: String };
  otherFeatures: String[];
  description: String;
  isApproved: Boolean;
  numberOfViews: Number;
  status: Status | null;
  boughtBy: mongoose.Types.ObjectId | null;
}

let realStateSchema = new Schema<RealStateEntity>(
  {
    _id: { type: Schema.Types.ObjectId, auto: true },
    title: { type: String, required: [true, "Title is required"] },
    photos: [{ type: Schema.Types.ObjectId, ref: "Photo" }],
    price: { type: Number, required: [true, "Price is required"] },
    category: {
      type: String,
      enum: RealStateCategory,
      required: [true, "Category is required"],
    },
    owner: { type: Schema.Types.ObjectId, ref: "User" },

    rooms: { type: Number, required: false, default: null },
    beds: { type: Number, required: false, default: null },
    baths: { type: Number, required: false, default: null },
    kitchens: { type: Number, required: false, default: null },
    seats: { type: Number, required: false, default: null },
    numberOfViews: { type: Number, required: false, default: 0 },

    sizeWidth: { type: Number, required: [true, "sizeWidth is required"] },
    sizeHeight: { type: Number, required: [true, "sizeHeight is required"] },
    sizeUnit: { type: String, required: [true, "Size unit is required"] },
    location: {
      region: { type: String, required: [true, "Region is required"] },
      district: { type: String, required: [true, "District is required"] },
      ward: { type: String, required: [true, "Ward is required"] },
    },
    otherFeatures: [{ type: String }],
    description: { type: String, required: [true, "Description is required"] },
    isApproved: { type: Boolean, default: true },
    status: { type: String, enum: Status, default: Status.AVAILABLE },
    boughtBy: { type: Schema.Types.ObjectId, ref: "User", required: false },
  },
  { timestamps: true }
);

export const RealState = mongoose.model<RealStateEntity>(
  "RealState",
  realStateSchema
);
