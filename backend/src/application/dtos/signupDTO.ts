import {
  IsDateString,
  IsEmail,
  IsEnum,
  IsNotEmpty,
  IsPhoneNumber,
  IsString,
  IsStrongPassword,
} from "class-validator";
import { Gender } from "domain/types/types";
import mongoose from "mongoose";
import { File } from "tsoa";
import { User } from "@entities/UserEntity";



export class SignUpDTO {
  constructor(props: SignUpDTO) {
    Object.assign(this, props);
  }


  @IsNotEmpty()
  @IsString()
  firstName: string;

  @IsNotEmpty()
  @IsString()
  middleName: string;

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


