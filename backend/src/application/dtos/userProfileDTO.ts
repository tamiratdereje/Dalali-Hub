import { PhotoEntity } from "@entities/PhotoEntity";
import { UserEntity } from "@entities/UserEntity";
import { differenceInYears } from "date-fns";
import { Gender } from "domain/types/gender";
import mongoose from "mongoose";

export class UserProfileDTO {
  constructor(props: UserEntity) {
    const res: any = Object.assign({}, { ...props, age: 0 });
    // filter fields that are in UserProfileDTO only
    Object.keys(res).forEach((key) => {
      if (!(key in this)) {
        delete res[key];
      }
    });

    Object.assign(this, res);
    this.age = differenceInYears(new Date(), props.dateOfBirth);
  }

  readonly id: string;
  readonly firstName: string;
  readonly lastName: string;
  readonly gender: Gender;
  readonly age: number;
  readonly photos: PhotoEntity[] | mongoose.ObjectId[];

}
