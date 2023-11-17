import { OtpType } from "@interfaces/services/IOtpService";
import { IsEnum, IsNotEmpty, IsPhoneNumber, IsString, Length, MAX_LENGTH, ValidateIf } from "class-validator";

export class VerifyOtpDTO {
  constructor(props: VerifyOtpDTO) {
    Object.assign(this, props);
  }

  @IsNotEmpty()
  @IsString()
  @Length(4, 4)
  otp: string;

  @IsNotEmpty()
  @IsPhoneNumber()
  @ValidateIf((o) => o.otpType === OtpType.PHONE)
  phoneNumber: string;

  @IsNotEmpty()
  @IsPhoneNumber()
  @ValidateIf((o) => o.otpType === OtpType.EMAIL)
  email: string;

  @IsNotEmpty()
  @IsEnum(OtpType)
  otpType: string;
  
}