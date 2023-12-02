import { Types } from "mongoose";
import { HouseCategory } from "domain/types/types";
import { LocationDTO } from "./LocationDTO";
import { uploadedFileDTO } from "./uploadedFileDTO";
import { PhotoResponseDTO } from "./photoResponseDTO";

export class HouseResponseDTO {
  constructor(
    public _id: Types.ObjectId,
    public title: String,
    public minPrice: Number,
    public maxPrice: Number,
    public category: HouseCategory,
    public rooms: Number,
    public beds: Number,
    public baths: Number,
    public kitchens: Number,
    public size: Number,
    public sizeUnit: String,
    public location: LocationDTO,
    public images: PhotoResponseDTO[], // Use uploadedFileDTO for images
    public otherFeatures: String[],
    public description: String,
    public isApproved: Boolean
  ) {}
}