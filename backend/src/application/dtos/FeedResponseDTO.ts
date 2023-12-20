import { Types } from "mongoose";
import { LocationDTO } from "./LocationDTO";
import { PhotoResponseDTO } from "./photoResponseDTO";
import { UserResponseDTO } from "./userResponseDTO";

export class FeedResponseDTO {
  constructor(
    public id: Types.ObjectId,
    public title: String | null,
    public category: String,
    public seats: Number | null,
    public sizeWidth: Number | null,
    public sizeHeight: Number | null,
    public sizeUnit: String | null,
    public location: LocationDTO,
    public photos: PhotoResponseDTO[],
    public otherFeatures: String[] | null,
    public description: String | null,
    public isApproved: Boolean,
    public rooms: Number | null,
    public beds: Number | null,
    public baths: Number | null,
    public kitchens: Number | null,
    public make: String | null,
    public model: String | null,
    public year: Number | null,
    public color: String | null,
    public vin: String | null,
    public fuelType: String | null,
    public engineSize: Number | null,
    public transmissionType: String | null,
    public mileage: Number | null,
    public price: Number | null,
    public condition: String | null,
    public owner: UserResponseDTO,
    public numberOfViews: Number,
    public isFavorite: Boolean | null
  ) {}
}
