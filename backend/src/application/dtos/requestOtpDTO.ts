import { IsNotEmpty, IsPhoneNumber, IsString } from "class-validator";

export class RequestOtpDTO {
  constructor(props: RequestOtpDTO) {
    Object.assign(this, props);
  }

  @IsNotEmpty()
  @IsString()
  @IsPhoneNumber("ET")
  phoneNumber: string;
}
