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
} from "class-validator";


import { RealStateCategory } from "domain/types/types";
import { LocationDTO } from "./LocationDTO";
import { Transform, TransformFnParams, Type } from "class-transformer";

export class RealStateDTO {
  constructor(props: RealStateDTO) {
    Object.assign(this, props, { location: new LocationDTO(props.location)});
  }

  @IsNotEmpty({ message: "Title is required" })
  @IsString({ message: "Title must be a string" })
  title: String;

  @IsNotEmpty({ message: "Price is required" })
  @IsNumber({}, { message: "Price must be a Number" })
  price: Number;


  @IsNotEmpty({ message: "Category is required" })
  @IsEnum(RealStateCategory, { message: "Invalid category" })
  category: RealStateCategory;

  // @IsNotEmpty({ message: "Rooms is required" })
  // @IsNumber({}, { message: "Rooms must be a Number" })
  rooms: Number | null;

  // @IsNotEmpty({ message: "Beds is required" })
  // @IsNumber({}, { message: "Beds must be a Number" })
  beds: Number | null;

  // @IsNotEmpty({ message: "Baths is required" })
  // @IsNumber({}, { message: "Baths must be a Number" })
  baths: Number | null;

  // @IsNotEmpty({ message: "Kitchens is required" })
  // @IsNumber({}, { message: "Kitchens must be a Number" })
  kitchens: Number | null;

  seats: Number | null;

  @IsNotEmpty({ message: "Size is required" })
  @IsNumber({}, { message: "widthSize must be a Number" })
  sizeWidth: Number;

  @IsNotEmpty({ message: "Size is required" })
  @IsNumber({}, { message: "heightSize must be a Number" })
  sizeHeight: Number;

  @IsNotEmpty({ message: "Size unit is required" })
  @IsString({ message: "Size unit must be a string" })
  sizeUnit: String;

  @IsObject()
  @IsNotEmptyObject()
  @ValidateNested()
  @Type(() => LocationDTO)
  location: LocationDTO;

  otherFeatures: String[];

  @IsNotEmpty({ message: "Description is required" })
  @IsString({ message: "Description must be a string" })
  description: String;

  @Transform(({ value }: TransformFnParams) => value?.trim())
  @IsBoolean({ message: "isApproved must be a boolean"})
  isApproved: Boolean;

  @IsNotEmpty({ message: "Owner id is required" })
  @IsString({ message: "Owner must be a string" })
  owner: String;

  @IsNotEmpty({ message: "number of views are required" })
  @IsNumber({}, { message: "number of views must be a Number" })
  numberOfViews: Number

  status: String | null;
}
