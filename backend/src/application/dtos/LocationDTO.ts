import {
  IsNotEmpty,
  IsString,
} from "class-validator";

export class LocationDTO {
  constructor(props: LocationDTO) {
    Object.assign(this, props);
  }

  @IsNotEmpty()
  @IsString()
  region: String;

  @IsNotEmpty()
  @IsString()
  district: String;

  @IsNotEmpty()
  @IsString()
  ward: String;
}
