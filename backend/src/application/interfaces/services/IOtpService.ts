export interface IOtpService {
  SendOtp(phoneNumber: string): Promise<boolean>;
  VerifyOtp(phoneNumber: string, otp: string): Promise<boolean>;
}
