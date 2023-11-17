import { OtpType } from "@interfaces/services/IOtpService";
import { IsEmail, IsEnum, IsNotEmpty, IsPhoneNumber, IsString, ValidateIf } from "class-validator";

export class RequestOtpDTO {
  constructor(props: RequestOtpDTO) {
    Object.assign(this, props);
  }
  @IsNotEmpty()
  @IsEnum(OtpType)
  otpType: string;

  @IsString()
  @IsEmail()
  @ValidateIf((o) => o.otpType === OtpType.EMAIL)
  email: string;
  
  @IsString()
  @IsPhoneNumber()
  @ValidateIf((o) => o.otpType === OtpType.PHONE)
  phoneNumber: string;

}
