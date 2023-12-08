import { Types } from "mongoose";
import { LocationDTO } from "./LocationDTO";
import { PhotoResponseDTO } from "./photoResponseDTO";

export class FeedResponseDTO {
   constructor(
        public id: Types.ObjectId,
        public title: String,
        public minPrice: Number,
        public maxPrice: Number,
        public category: String,
        public seats: Number | null,
        public size: Number,
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

     ) {}
}