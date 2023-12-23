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
  }
  
  
  