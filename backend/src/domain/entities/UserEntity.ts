import { Gender } from "domain/types/gender";
import mongoose, { Schema } from "mongoose";
import { IBaseEntity } from "./BaseEntity";


const pointSchema = new mongoose.Schema({
  type: {
    type: String,
    enum: ["Point"],
    required: true,
  },
  coordinates: {
    type: [Number],
    required: true,
  },
});

export interface DiscoverySettingsEntity extends IBaseEntity {
  targetGender: Gender;
  minAge: number;
  maxAge: number;
  maxDistanceKilometers: number;
}

export interface UserEntity extends IBaseEntity {
  id: string;
  firstName: string;
  lastName: string;
  gender: Gender;
  dateOfBirth: Date;
  height: number;

  photos: mongoose.ObjectId[];
  interests: mongoose.ObjectId[];
  relationshipGoals: mongoose.ObjectId;
  languages: mongoose.ObjectId[];
  religion: mongoose.ObjectId;

  bio: string;
  jobTitle: string;
  company: string;
  school: string;
  hometown: string;
  location: { type: string; coordinates: [number, number] };

  phone: string;

  discoverySettings: DiscoverySettingsEntity;
}

let discoverySettingsSchema = new Schema<DiscoverySettingsEntity>(
  {
    minAge: { type: Number, required: [true, "Min age is required"] },
    maxAge: { type: Number, required: [true, "Max age is required"] },
    maxDistanceKilometers: {
      type: Number,
      required: [true, "Max distance is required"],
    },
  },
  { timestamps: true },
);

let userSchema = new Schema<UserEntity>(
  {
    firstName: { type: String, required: [true, "First name is required"] },
    lastName: { type: String, required: [true, "Last name is required"] },
    gender: {
      type: String,
      enum: Gender,
      required: [true, "Gender is required"],
    },
    dateOfBirth: { type: Date, required: [true, "Date of birth is required"] },
    height: { type: Number },
    photos: [{ type: Schema.Types.ObjectId, ref: "Photo" }],
    interests: [{ type: Schema.Types.ObjectId, ref: "Attribute" }],
    relationshipGoals: { type: Schema.Types.ObjectId, ref: "Attribute" },
    languages: [{ type: Schema.Types.ObjectId, ref: "Attribute" }],
    religion: { type: Schema.Types.ObjectId, ref: "Attribute" },
    bio: { type: String },
    jobTitle: { type: String },
    company: { type: String },
    school: { type: String },
    hometown: { type: String },
    location: {
      type: pointSchema,
      default: { type: "Point", coordinates: [0, 0] },
    },
    phone: {
      type: String,
      required: [true, "Phone is required"],
      unique: true,
    },
    discoverySettings: {
      type: discoverySettingsSchema,
      default: {
        minAge: 18,
        maxAge: 70,
        maxDistanceKilometers: 10,
      },
    },
  },
  { timestamps: true },
);

// TODO: Add indexes
userSchema.index({ location: "2dsphere" });

export const User = mongoose.model<UserEntity>("User", userSchema);
