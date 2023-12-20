import { Types } from "mongoose";
import { LocationDTO } from "./LocationDTO";
import { PhotoResponseDTO } from "./photoResponseDTO";
import { UserResponseDTO } from "./userResponseDTO";

export class VehicleResponseDTO {
  constructor(
    public id: Types.ObjectId,
    public make: String,
    public model: String,
    public year: Number,
    public color: String,
    public vin: String,
    public fuelType: String,
    public engineSize: Number,
    public photos: PhotoResponseDTO[],
    public location: LocationDTO,
    public transmissionType: String,
    public mileage: Number,
    public price: Number,
    public condition: String,
    public category: String,
    public isApproved: Boolean,
    public owner: UserResponseDTO,
    public numberOfViews: Number,
    public isFavorite: Boolean | null
  ) {}
}
