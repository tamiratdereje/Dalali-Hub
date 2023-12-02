import { Types } from "mongoose";
import { uploadedFileDTO } from "./uploadedFileDTO";
import { LocationDTO } from "./LocationDTO";
import { PhotoResponseDTO } from "./photoResponseDTO";

export class LandResponseDTO {
  constructor(
    public _id: Types.ObjectId,
    public title: String,
    public minPrice: Number,
    public maxPrice: Number,
    public category: String, // Assuming category is a String, update as needed
    public size: Number,
    public sizeUnit: String,
    public location: LocationDTO,
    public images: PhotoResponseDTO[],
    public otherFeatures: String[],
    public description: String,
    public isApproved: Boolean
  ) {}
}
