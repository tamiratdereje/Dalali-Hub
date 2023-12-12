import 'reflect-metadata';
import {
  IsNotEmpty,
  IsString,
  IsNumber,
  IsEnum,
  ValidateNested,
  IsObject,
  IsBooleanString,
  IsNotEmptyObject,
} from "class-validator";
import { Transform, TransformFnParams, Type } from "class-transformer";
import { LocationDTO } from './LocationDTO';

export class VehicleDTO {
  constructor(props: VehicleDTO) {
    Object.assign(this, props);
  }

  @IsNotEmpty({ message: "Make is required" })
  @IsString({ message: "Make must be a String" })
  make: String;

  @IsNotEmpty({ message: "Model is required" })
  @IsString({ message: "Model must be a String" })
  model: String;

  @IsNotEmpty({ message: "Year is required" })
  @IsNumber({}, { message: "Year must be a Number" })
  year: Number;

  @IsNotEmpty({ message: "Color is required" })
  @IsString({ message: "Color must be a String" })
  color: String;

  @IsNotEmpty({ message: "VIN is required" })
  @IsString({ message: "VIN must be a String" })
  vin: String;

  @IsNotEmpty({ message: "Fuel type is required" })
  @IsString({ message: "Fuel type must be a String" })
  fuelType: String;

  @IsNotEmpty({ message: "Engine size is required" })
  @IsNumber({}, { message: "Engine size must be a Number" })
  engineSize: Number;

  @IsNotEmpty({ message: "Transmission type is required" })
  @IsString({ message: "Transmission type must be a String" })
  transmissionType: String;

  @IsNotEmpty({ message: "Mileage is required" })
  @IsNumber({}, { message: "Mileage must be a Number" })
  mileage: Number;

  @IsNotEmpty({ message: "Price is required" })
  @IsNumber({}, { message: "Price must be a Number" })
  price: Number;

  @IsObject()
  @IsNotEmptyObject()
  @ValidateNested()
  @Type(() => LocationDTO)
  location: LocationDTO;

  @IsNotEmpty({ message: "Condition is required" })
  @IsString({ message: "Condition must be a String" })
  condition: String;

}