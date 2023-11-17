import { OtpType } from "@interfaces/services/IOtpService";
import { IsEnum, IsNotEmpty, IsPhoneNumber, IsString, IsStrongPassword, Length, ValidateIf } from "class-validator";

export class ResetPasswordDTO {
  constructor(props: ResetPasswordDTO) {
    Object.assign(this, props);
  }

  @IsNotEmpty()
  @IsString()
  @IsStrongPassword()
  newPassword: string;

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
