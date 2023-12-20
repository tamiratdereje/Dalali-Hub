import { Types } from "mongoose";
import { LocationDTO } from "./LocationDTO";
import { PhotoResponseDTO } from "./photoResponseDTO";
import { UserResponseDTO } from "./userResponseDTO";

export class RealStateResponseDTO {
   constructor(
        public id: Types.ObjectId,
        public title: String,
        public price: Number,
        public category: String,
        public seats: Number | null,
        public sizeWidth: Number,
        public sizeHeight: Number,
        public sizeUnit: String,
        public location: LocationDTO,
        public photos: PhotoResponseDTO[] ,
        public otherFeatures: String[],
        public description: String,
        public isApproved: Boolean,
        public rooms: Number | null,
        public beds: Number | null,
        public baths: Number | null,
        public kitchens: Number | null,
        public owner: UserResponseDTO,
        public numberOfViews: Number,
        public isFavorite: Boolean |null

     ) {}
}