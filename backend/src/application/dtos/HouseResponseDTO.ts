import { Types } from "mongoose";
import { HouseCategory } from "domain/types/types";
import { LocationDTO } from "./LocationDTO";
import { uploadedFileDTO } from "./uploadedFileDTO";

export class HouseResponseDTO {
  constructor(
    public _id: Types.ObjectId,
    public title: string,
    public minPrice: number,
    public maxPrice: number,
    public category: HouseCategory,
    public rooms: number,
    public beds: number,
    public baths: number,
    public kitchens: number,
    public size: number,
    public sizeUnit: string,
    public location: LocationDTO,
    public images: uploadedFileDTO[], // Use uploadedFileDTO for images
    public otherFeatures: string[],
    public description: string,
    public isApproved: boolean,
  ) {}
}