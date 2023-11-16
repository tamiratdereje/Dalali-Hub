import { IOtpService } from "@interfaces/services/IOtpService";

export class DummyOtpService implements IOtpService {
  private otpRecord: Map<string, string>;

  constructor() {
    this.otpRecord = new Map<string, string>();
  }

  SendOtp(phoneNumber: string): Promise<boolean> {
    const otp = Math.floor(1000 + Math.random() * 9000).toString();
    this.otpRecord.set(phoneNumber, otp);
    console.log(`OTP for ${phoneNumber} is ${otp}`);
    return Promise.resolve(true);
  }

  VerifyOtp(phoneNumber: string, otp: string): Promise<boolean> {
    const storedOtp = this.otpRecord.get(phoneNumber);
    if (storedOtp === otp) {
      return Promise.resolve(true);
    }
    return Promise.resolve(false);
  }
}
