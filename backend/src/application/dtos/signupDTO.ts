import 'reflect-metadata';

import {
  IsNotEmpty,
  IsString,
  IsEnum,
  ValidateNested,
  IsNotEmptyObject,
  IsObject,
  IsPhoneNumber,
  IsEmail,
  IsStrongPassword,
} from "class-validator";
import { Gender } from "domain/types/types";
import { LocationDTO } from "./LocationDTO";
import { Type } from "class-transformer";


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
  district: string;

  @IsNotEmpty()
  @IsString()
  ward: string;

  @IsNotEmpty()
  @IsString()
  @IsStrongPassword()
  password: string;

  @IsNotEmpty()
  @IsString()
  role: string;

  @IsObject()
  @IsNotEmptyObject()
  @ValidateNested()
  @Type(() => LocationDTO)
  location: LocationDTO;
}
