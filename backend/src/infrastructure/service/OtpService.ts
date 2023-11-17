import { OtpModel } from "@entities/OtpEntity";
import { UserEntity } from "@entities/UserEntity";
import { IOtpRepository } from "@interfaces/repositories/IOtpRepository";
import { IUserRepository } from "@interfaces/repositories/IUserRepository";
import { IMailService } from "@interfaces/services/IMailService";
import { IOtpService, OtpType } from "@interfaces/services/IOtpService";
import  * as bcrypt from "bcrypt";
import mongoose from "mongoose";



export class OtpService implements IOtpService {
 

  constructor(
    private mailService: IMailService,
    private otpRepository: IOtpRepository,
    private userRepository: IUserRepository
  ) {}

  async SendOtp(user: UserEntity, otpType: OtpType): Promise<boolean> {
    const otp = Math.floor(1000 + Math.random() * 9000).toString();
  
    if(otpType === OtpType.PHONE){
      // send otp to phone
      throw new Error("Method not implemented.");
    } else {
      // send otp to email
      const mailOptions = {
        from: process.env.EMAIL,
        to: user.email,
        subject: '[ Dalali Hub ] please verify your email',
        template: 'verification_template',
        context: {
          name: `${user.firstName} ${user.sirName}`,
          otp: otp
        }
      };
      var emailSent = await this.mailService.sendEmail(mailOptions);
      if(!emailSent){ throw new Error("Could not send email"); }
    }

    const otpEntity =  new OtpModel({
      otp: bcrypt.hashSync(otp, 10),
      expiresAt: new Date(new Date().getTime() + 5 * 60000),
      user: user._id
    });

    // find existing otp of current user
    const existingOtp = await this.otpRepository.GetOtpByUserId(user._id);
    if(existingOtp){ await this.otpRepository.Update(existingOtp._id, otpEntity); }
    else { await this.otpRepository.Create(otpEntity); }
    return Promise.resolve(true);
  }


  async VerifyOtp(user: UserEntity, otp: string): Promise<boolean> {
    // check if otp exists
    const storedOtp = await this.otpRepository.GetOtpByUserId(user._id);
    if (!storedOtp) { throw new Error("Otp not found"); }

    // check if otp has expired
    const otpExpiry = new Date(storedOtp.expiresAt);
    const now = new Date();
    if (otpExpiry < now) { throw new Error("Otp has expired"); }

    // check if another user has the same email or phone and is verified
    const activeUserExistsDifferentId = 
    await this.userRepository.activeUserExistsDifferentId(user.email, user.phoneNumber, user._id );
    if (activeUserExistsDifferentId) { throw new Error("Email or phone already exists"); }

    // check if otp matches
    const isMatch = bcrypt.compare(otp, storedOtp.otp);
    if (isMatch) { 
      await this.otpRepository.Delete(storedOtp._id);
      return Promise.resolve(true); 
    }
    return Promise.resolve(false);
  }
}
