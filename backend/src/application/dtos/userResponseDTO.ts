import { PhotoEntity } from "@entities/PhotoEntity";
import { UserEntity } from "@entities/UserEntity";
import { differenceInYears } from "date-fns";
import { Gender } from "domain/types/types";
import mongoose, { Types } from "mongoose";
import { PhotoResponseDTO } from "./photoResponseDTO";
import { LocationResponseDTO } from "./LocationResponseDTO";

export class UserResponseDTO {
  constructor(
    public id: Types.ObjectId,
    public  firstName: string,
    public  middleName: string,
    public  sirName: string,
    public  email: string,
    public  phoneNumber: string,
    public  gender: Gender,
    public  location: LocationResponseDTO,
    public  photos: PhotoResponseDTO[],
    public role: string,
  ) {}
}