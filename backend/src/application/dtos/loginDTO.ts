import { IsNotEmpty, IsPhoneNumber, IsString } from "class-validator";

export class LoginDTO {
  constructor(props: LoginDTO) {
    Object.assign(this, props);
  }

  @IsNotEmpty()
  @IsString()
  @IsPhoneNumber("ET")
  phoneNumber: string;

  @IsNotEmpty()
  @IsString()
  otp: string;
}
