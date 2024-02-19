import { Gender, Role } from "domain/types/types";
import mongoose, { Schema, Types } from "mongoose";
import { IBaseEntity } from "./BaseEntity";
import * as bcrypt from "bcrypt";

export interface UserEntity extends IBaseEntity {
  _id: Types.ObjectId;
  firstName: string;
  middleName: string;
  sirName: string;
  email: string;
  phoneNumber: string;
  gender: Gender;
  region: string;
  photos: mongoose.Types.ObjectId[];
  password: string;
  isVerified: boolean;
  role: Role;
  location: {region: String, district: String, ward: String};

}

let userSchema = new Schema<UserEntity>(
  {
    _id: { type: Schema.Types.ObjectId, auto: true },
    firstName: { type: String, required: [true, "First name is required"] },
    middleName: { type: String, required: [true, "Middle name is required"] },
    sirName: { type: String, required: [true, "Sir name is required"] },
    gender: {
      type: String,
      enum: Gender,
      required: [true, "Gender is required"],
    },
    photos: [{ type: Schema.Types.ObjectId, ref: "Photo" }],
    phoneNumber: {
      type: String,
      required: [true, "Phone is required"],
      unique: true,
    },
    email: {
      type: String,
      unique: true,
      required: [true, "Email is required"],
    },
    role: { type: String, enum: Role, default: Role.Customer },
    password: { type: String, required: [true, "Password is required"] },
    location: {
      region: { type: String, required: [true, "Region is required"] },
      district: { type: String, required: [true, "District is required"] },
      ward: { type: String, required: [true, "Ward is required"] },
    },
    isVerified: { type: Boolean, default: false },
  },
  { timestamps: true }
);

userSchema.methods.toJSON = function () {
  let obj = this.toObject();
  delete obj.password;
  return obj;
};

userSchema.pre("save", function (next) {
  if (!this.isModified("password")) {
    return next();
  }
  this.password = bcrypt.hashSync(this.password, 10);

  next();
});

export const User = mongoose.model<UserEntity>("User", userSchema);
