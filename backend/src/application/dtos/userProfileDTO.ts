import { PhotoEntity } from "@entities/PhotoEntity";
import { UserEntity } from "@entities/UserEntity";
import { differenceInYears } from "date-fns";
import { Gender } from "domain/types/gender";
import mongoose from "mongoose";

export class UserProfileDTO {
  constructor(props: UserEntity) {
    const res: any = Object.assign({}, { ...props, age: 0 });
    Object.assign(this, res);
  }

  readonly id: string;
  readonly firstName: string;
  readonly middleName: string;
  readonly sirName: string;
  readonly email: string;
  readonly phoneNumber: string;
  readonly gender: Gender;
  readonly region: string;
  readonly photos: PhotoEntity[] | mongoose.Types.ObjectId[];

}
/*
firstName: string;
  middleName: string;
  sirName: string;
  email: string;
  phoneNumber: string;
  gender: Gender;
  region: string;
  photos: mongoose.Types.ObjectId[];
  password: string;
  isVerified: boolean;
*/ 