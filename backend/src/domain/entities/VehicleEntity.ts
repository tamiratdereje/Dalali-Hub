import mongoose, { Schema, Types } from "mongoose";
import { IBaseEntity } from "./BaseEntity";

export interface VehicleEntity extends IBaseEntity {
  _id: Types.ObjectId;
  make: String;
  photos: mongoose.Types.ObjectId[];
  model: String;
  year: Number;
  color: String;
  vin: String;
  fuelType: String;
  engineSize: Number;
  transmissionType: String;
  mileage: Number;
  price: Number;
  location: {region: String, district: String, ward: String};
  condition: String;
//   insuranceDetails: {
//     policyNumber: String;
//     expirationDate: Date;
//   };
}

const vehicleSchema = new Schema<VehicleEntity>(
  {
    _id: { type: Schema.Types.ObjectId, auto: true },
    make: { type: String, required: [true, "Make is required"] },
    model: { type: String, required: [true, "Model is required"] },
    photos: [{ type: Schema.Types.ObjectId, ref: "Photo" }],
    year: { type: Number, required: [true, "Year is required"] },
    color: { type: String, required: [true, "Color is required"] },
    vin: { type: String, required: [true, "VIN is required"] },
    fuelType: { type: String, required: [true, "Fuel type is required"] },
    engineSize: { type: Number, required: [true, "Engine size is required"] },
    transmissionType: { type: String, required: [true, "Transmission type is required"] },
    mileage: { type: Number, required: [true, "Mileage is required"] },
    price: { type: Number, required: [true, "Price is required"] },
    location: {
      region: { type: String, required: [true, "Region is required"] },
      district: { type: String, required: [true, "District is required"] },
      ward: { type: String, required: [true, "Ward is required"] },
    },
    condition: { type: String, required: [true, "Condition is required"] },
    // insuranceDetails: {
    //   policyNumber: { type: String, required: [true, "Policy Number is required"] },
    //   expirationDate: { type: Date, required: [true, "Expiration date is required"] },
    // },
  },
  { timestamps: true }
);

export const Vehicle = mongoose.model<VehicleEntity>("Vehicle", vehicleSchema);
