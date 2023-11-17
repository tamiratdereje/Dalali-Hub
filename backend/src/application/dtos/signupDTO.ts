import {
  IsDateString,
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsPhoneNumber,
  IsString,
  IsStrongPassword,
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
  midName: string;

  @IsNotEmpty()
  @IsString()
  sirName: string;

  @IsNotEmpty()
  @IsString()
  @IsEmail()
  email: string;

  @IsNotEmpty()
  @IsString()
  @IsPhoneNumber()
  phoneNumber: string;

  @IsNotEmpty()
  @IsEnum(Gender)
  gender: Gender;

  @IsNotEmpty()
  @IsString()
  region: string;

  @IsNotEmpty()
  @IsString()
  @IsStrongPassword()
  password: string;

}


