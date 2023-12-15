import { Types } from "mongoose";
import { UserResponseDTO } from "./userResponseDTO";
import { RealStateResponseDTO } from "./RealStateResponseDTO";
import { FeedResponseDTO } from "./FeedResponseDTO";

export class FavoriteResponseDTO {
  constructor(
    public id: Types.ObjectId,
    public property: FeedResponseDTO,
  ) {}
}