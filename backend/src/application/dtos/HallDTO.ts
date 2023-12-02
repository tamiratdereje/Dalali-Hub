import 'reflect-metadata';

import {
    IsNotEmpty,
    IsString,
    IsNumberString,
    IsArray,
    IsEnum,
    IsBoolean,
    ValidateNested,
    ArrayMinSize,
    IsObject,
    IsNotEmptyObject,
    IsBooleanString,
  } from "class-validator";
  import { Transform, TransformFnParams, Type } from "class-transformer";
import { LocationDTO } from "./LocationDTO";
  
export class HallDTO {
    constructor(props: HallDTO) {
      Object.assign(this, props, {location: new LocationDTO(props.location)});
    }
  
    @IsNotEmpty({ message: "Title is required" })
    @IsString({ message: "Title must be a string" })
    title: String;
    
    @IsNotEmpty({ message: "Min price is required" })
    @IsNumberString({}, { message: "Min price must be a Number" })
    minPrice: Number;
  
    @IsNotEmpty({ message: "Max price is required" })
    @IsNumberString({}, { message: "Max price must be a Number" })
    maxPrice: Number;
  
    @IsNotEmpty({ message: "Category is required" })
    @IsString({ message: "Category must be a string" })
    category: String;
  
    @IsNotEmpty({ message: "Seats is required" })
    @IsNumberString({}, { message: "Seats must be a Number" })
    seats: Number;
  
    @IsNotEmpty({ message: "Size is required" })
    @IsNumberString({}, { message: "Size must be a Number" })
    size: Number;
  
    @IsNotEmpty({ message: "Size unit is required" })
    @IsString({ message: "Size unit must be a string" })
    sizeUnit: String;
  
    @IsObject()
    @IsNotEmptyObject()
    @ValidateNested()
    @Type(() => LocationDTO)
    location: LocationDTO;
  
    // @ArrayMinSize(0, { message: "At least zero other feature is required" })
    otherFeatures: String[];
  
    @IsNotEmpty({ message: "Description is required" })
    @IsString({ message: "Description must be a string" })
    description: String;
  
    @Transform(({ value }: TransformFnParams) => value?.trim())
    @IsBooleanString({ message: "isApproved must be a boolean"})
    isApproved: Boolean;
  }
  