import {
  IsDateString,
  IsEnum,
  IsNotEmpty,
  IsPhoneNumber,
  IsString,
} from "class-validator";
import { Gender } from "domain/types/gender";
import { File } from "tsoa";

export class SignUpDTO {
  constructor(props: SignUpDTO) {
    Object.assign(this, props);
  }

  @IsNotEmpty()
  @IsString()
  firstName: string;

  @IsNotEmpty()
  @IsString()
  lastName: string;

  @IsNotEmpty()
  @IsEnum(Gender)
  gender: Gender;

  // TODO: Add validation for age
  @IsNotEmpty()
  @IsDateString()
  dateOfBirth: Date;

  @IsNotEmpty()
  @IsString()
  @IsPhoneNumber("ET")
  phone: string;

  // @IsNotEmpty()
  interests: string[];

  @IsNotEmpty()
  @IsString()
  otp: string;
}
