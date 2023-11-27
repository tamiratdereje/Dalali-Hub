import { Types } from "mongoose";
import { uploadedFileDTO } from "./uploadedFileDTO";
import { LocationDTO } from "./LocationDTO";

export class LandResponseDTO {
  constructor(
    public _id: Types.ObjectId,
    public title: string,
    public minPrice: number,
    public maxPrice: number,
    public category: string, // Assuming category is a string, update as needed
    public size: number,
    public sizeUnit: string,
    public location: LocationDTO,
    public images: uploadedFileDTO[],
    public otherFeatures: string[],
    public description: string,
    public isApproved: boolean,
  ) {}
}
