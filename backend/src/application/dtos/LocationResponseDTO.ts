import { Types } from "mongoose";
import { uploadedFileDTO } from "./uploadedFileDTO";
import { LocationDTO } from "./LocationDTO";

export class LocationResponseDTO {
  constructor(
    public region: String,
    public district: String,
    public ward: String,
    
  ) {}
}
