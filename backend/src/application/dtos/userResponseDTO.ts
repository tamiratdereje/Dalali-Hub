import { PhotoEntity } from "@entities/PhotoEntity";
import { UserEntity } from "@entities/UserEntity";
import { differenceInYears } from "date-fns";
import { Gender } from "domain/types/types";
import mongoose, { Types } from "mongoose";

export class UserResponseDTO {
  constructor(
    public _id: Types.ObjectId,
    public  firstName: string,
    public  middleName: string,
    public  sirName: string,
    public  email: string,
    public  phoneNumber: string,
    public  gender: Gender,
    public  region: string,
    public  photos: PhotoEntity[] | mongoose.Types.ObjectId[],
  ) {}
}