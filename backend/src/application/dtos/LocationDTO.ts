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
  country: String;

  @IsNotEmpty()
  @IsString()
  city: String;

  @IsNotEmpty()
  @IsString()
  street: String;
}
