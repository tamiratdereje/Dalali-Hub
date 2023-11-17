import { UserEntity } from "@entities/UserEntity";

export interface IOtpService {
  SendOtp(user: UserEntity, otpType: OtpType): Promise<boolean>;
  VerifyOtp(user: UserEntity, otp: string): Promise<boolean>;
}

export enum OtpType {
  EMAIL = "email",
  PHONE = "phone",
}