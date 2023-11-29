import 'reflect-metadata';
import {
  IsNotEmpty,
  IsString,
  IsNumber,
  IsEnum,
  IsBoolean,
  ValidateNested,
  ArrayMinSize,
  IsDefined,
  IsNotEmptyObject,
  IsObject,
  IsBooleanString,
  IsNumberString
} from "class-validator";


import { HouseCategory } from "domain/types/types";
import { LocationDTO } from "./LocationDTO";
import { Transform, TransformFnParams, Type } from "class-transformer";

export class HouseDTO {
  constructor(props: HouseDTO) {
    Object.assign(this, props, { location: new LocationDTO(props.location)});
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
  @IsEnum(HouseCategory, { message: "Invalid house category" })
  category: HouseCategory;

  @IsNotEmpty({ message: "Rooms is required" })
  @IsNumberString({}, { message: "Rooms must be a Number" })
  rooms: Number;

  @IsNotEmpty({ message: "Beds is required" })
  @IsNumberString({}, { message: "Beds must be a Number" })
  beds: Number;

  @IsNotEmpty({ message: "Baths is required" })
  @IsNumberString({}, { message: "Baths must be a Number" })
  baths: Number;

  @IsNotEmpty({ message: "Kitchens is required" })
  @IsNumberString({}, { message: "Kitchens must be a Number" })
  kitchens: Number;

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
