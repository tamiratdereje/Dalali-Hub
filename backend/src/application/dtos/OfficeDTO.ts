import {
    IsNotEmpty,
    IsString,
    IsNumber,
    IsEnum,
    IsBoolean,
    ValidateNested,
    ArrayMinSize,
  } from "class-validator";
  import { Type } from "class-transformer";
  import { HouseCategory } from "domain/types/types";
  import { LocationDTO } from "./LocationDTO";
  
  export class OfficeDTO {
    constructor(props: OfficeDTO) {
      Object.assign(this, props);
    }
  
    @IsNotEmpty({ message: "Title is required" })
    @IsString({ message: "Title must be a string" })
    title: String;
  
    @ArrayMinSize(0, { message: "At least zero photos are required" })
    photos: string[]; // Assuming the IDs of the photos
  
    @IsNotEmpty({ message: "Min price is required" })
    @IsNumber({}, { message: "Min price must be a Number" })
    minPrice: Number;
  
    @IsNotEmpty({ message: "Max price is required" })
    @IsNumber({}, { message: "Max price must be a Number" })
    maxPrice: Number;
  
    @IsNotEmpty({ message: "Category is required" })
    @IsEnum(HouseCategory, { message: "Invalid house category" })
    category: String;
  
    @IsNotEmpty({ message: "Rooms is required" })
    @IsNumber({}, { message: "Rooms must be a Number" })
    rooms: Number;
  
    @IsNotEmpty({ message: "Size is required" })
    @IsNumber({}, { message: "Size must be a Number" })
    size: Number;
  
    @IsNotEmpty({ message: "Size unit is required" })
    @IsString({ message: "Size unit must be a string" })
    sizeUnit: String;
  
    @IsNotEmpty()
    @ValidateNested()
    @Type(() => LocationDTO)
    location: LocationDTO;
  
    @ArrayMinSize(0, { message: "At least zero other feature is required" })
    otherFeatures: String[];
  
    @IsNotEmpty({ message: "Description is required" })
    @IsString({ message: "Description must be a string" })
    description: String;
  
    @IsBoolean({ message: "isApproved must be a boolean" })
    isApproved: Boolean;
  }
  