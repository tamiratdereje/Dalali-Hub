import { HouseCategory } from "domain/types/types";
import mongoose, { Schema, Types } from "mongoose";
import { IBaseEntity } from "./BaseEntity";


export interface OfficeEntity extends IBaseEntity {
  _id: Types.ObjectId;
  title: String;
  photos: mongoose.Types.ObjectId[];
  price: {
    minPrice: Number;
    maxPrice: Number;
  };
  category: String;
  rooms: Number;
  size: Number;
  sizeUnit: String;
  location: mongoose.Types.ObjectId;
  otherFeatures: String[];
  description: String;
  isApproved: Boolean;
}

let officeSchema = new Schema<OfficeEntity>(
  {
    _id: { type: Schema.Types.ObjectId, auto: true },
    title: { type: String, required: [true, "Title is required"] },
    photos: [{ type: Schema.Types.ObjectId, ref: "Photo" }],
    price: {
      minPrice: { type: Number, required: [true, "Min price is required"] },
      maxPrice: { type: Number, required: [true, "Max price is required"] },
    },
    category: {
      type: String,
      enum: HouseCategory,
      required: [true, "Category is required"],
    },
    rooms: { type: Number, required: [true, "Rooms is required"] },
    size: { type: Number, required: [true, "Size is required"] },
    sizeUnit: { type: String, required: [true, "Size unit is required"] },
    location: {
      type: Schema.Types.ObjectId,
      ref: "Location",
      required: [true, "Location is required"],
    },
    otherFeatures: [{ type: String }],
    description: { type: String, required: [true, "Description is required"] },
    isApproved: { type: Boolean, default: true },
  },
  { timestamps: true }
);

export const Office = mongoose.model<OfficeEntity>("Office", officeSchema);
