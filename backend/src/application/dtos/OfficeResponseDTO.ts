import { Types } from "mongoose";
import { HouseCategory } from "domain/types/types";
import { LocationDTO } from "./LocationDTO";
import { uploadedFileDTO } from "./uploadedFileDTO";

export class OfficeResponseDTO {
  constructor(
    public _id: Types.ObjectId,
    public title: string,
    public minPrice: number,
    public maxPrice: number,
    public category: HouseCategory,
    public rooms: number,
    public size: number,
    public sizeUnit: string,
    public location: LocationDTO,
    public images: uploadedFileDTO[],
    public otherFeatures: string[],
    public description: string,
    public isApproved: boolean,
  ) {}
}
