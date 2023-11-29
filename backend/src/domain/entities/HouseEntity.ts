import { HouseCategory } from "domain/types/types";
import mongoose, { Schema, Types } from "mongoose";
import { IBaseEntity } from "./BaseEntity";

export interface RegionEntity extends IBaseEntity {
  _id: Types.ObjectId;
  region: String;
  district: String;
  ward: String;
}

export interface HouseEntity extends IBaseEntity {
  _id: Types.ObjectId;
  title: String;
  photos: mongoose.Types.ObjectId[];
  
  minPrice: Number;
  maxPrice: Number;

  category: HouseCategory;
  rooms: Number;
  beds: Number;
  baths: Number;
  kitchens: Number;
  size: Number;
  sizeUnit: String;
  location: {};
  otherFeatures: String[];
  description: String;
  isApproved: Boolean;
}

let houseSchema = new Schema<HouseEntity>(
  {
    _id: { type: Schema.Types.ObjectId, auto: true },
    title: { type: String, required: [true, "Title is required"] },
    photos: [{ type: Schema.Types.ObjectId, ref: "Photo" }],
    minPrice: { type: Number, required: [true, "Min price is required"] },
    maxPrice: { type: Number, required: [true, "Max price is required"] },
    category: {
      type: String,
      enum: HouseCategory,
      required: [true, "Category is required"],
    },
    rooms: { type: Number, required: [true, "Rooms is required"] },
    beds: { type: Number, required: [true, "Beds is required"] },
    baths: { type: Number, required: [true, "Baths is required"] },
    kitchens: { type: Number, required: [true, "Kitchens is required"] },
    size: { type: Number, required: [true, "Size is required"] },
    sizeUnit: { type: String, required: [true, "Size unit is required"] },
    location: {
      region: { type: String, required: [true, "Region is required"] },
      district: { type: String, required: [true, "District is required"] },
      ward: { type: String, required: [true, "Ward is required"] },
    },
    otherFeatures: [{ type: String }],
    description: { type: String, required: [true, "Description is required"] },
    isApproved: { type: Boolean, default: true },
  },
  { timestamps: true }
);

export const House = mongoose.model<HouseEntity>("House", houseSchema);
