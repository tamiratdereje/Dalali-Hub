import { IsNotEmpty, IsString } from "class-validator";

export class ViewDTO {
  constructor(props: ViewDTO) {
    Object.assign(this, props);
  }
  @IsNotEmpty({ message: "User is required" })
  @IsString({ message: "User must be a String" })
  user: String;

  @IsNotEmpty({ message: "Property is required" })
  @IsString({ message: "Property must be a String" })
  property: String;
}
