import {IsNotEmpty, IsString, IsStrongPassword } from "class-validator";

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
  resetToken: string;

}
