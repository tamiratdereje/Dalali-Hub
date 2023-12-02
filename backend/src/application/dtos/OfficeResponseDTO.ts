import { Types } from "mongoose";
import { HouseCategory } from "domain/types/types";
import { LocationDTO } from "./LocationDTO";
import { PhotoResponseDTO } from "./photoResponseDTO";

export class OfficeResponseDTO {
  constructor(
    public _id: Types.ObjectId,
    public title: String,
    public minPrice: Number,
    public maxPrice: Number,
    public category: String,
    public rooms: Number,
    public size: Number,
    public sizeUnit: String,
    public location: LocationDTO,
    public images: PhotoResponseDTO[],
    public otherFeatures: String[],
    public description: String,
    public isApproved: Boolean,
  ) {}
}
