import {
    IsDateString,
    IsEmail,
    IsEnum,
    IsNotEmpty,
    IsNotEmptyObject,
    IsObject,
    IsPhoneNumber,
    IsString,
    IsStrongPassword,
    ValidateNested,
  } from "class-validator";
  import { Gender } from "domain/types/types";
import { LocationDTO } from "./LocationDTO";
import { Type } from "class-transformer";
  
  
  
  export class UpdateUserDTO {
    constructor(props: UpdateUserDTO) {
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
  role: string;

  @IsObject()
  @IsNotEmptyObject()
  @ValidateNested()
  @Type(() => LocationDTO)
  location: LocationDTO;
  }
  
  
  