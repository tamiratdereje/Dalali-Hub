import { LoginDTO } from "@dtos/loginDTO";
import { LoginResponseDTO } from "@dtos/loginResponseDTO";
import { UserEntity } from "@entities/UserEntity";
import { BadRequestError } from "@error-custom/BadRequestError";
import { IUserRepository } from "@interfaces/repositories/IUserRepository";
import { IOtpService } from "@interfaces/services/IOtpService";
import * as bcrypt from "bcrypt";
import { Gender } from "domain/types/gender";
import * as jwt from "jsonwebtoken";
import mongoose from "mongoose";
import { GenericRepository } from "./GenericRepository";

export class UserRepository
  extends GenericRepository<UserEntity>
  implements IUserRepository
{
  constructor(
    schema: mongoose.Model<UserEntity>,
    private _otpService: IOtpService,
  ) {
    super(schema);
  }

  async Login(loginDTO: LoginDTO): Promise<LoginResponseDTO> {
    const user = await this._schema.findOne({ phone: loginDTO.phoneNumber });

    if (!user) {
      throw new BadRequestError("Invalid credentials");
    }

    // Verify OTP
    if (
      !(await this._otpService.VerifyOtp(loginDTO.phoneNumber, loginDTO.otp))
    ) {
      throw new BadRequestError("Invalid OTP");
    }

    const token = await this.generateToken(user);
    const response = new LoginResponseDTO(user.id, token);
    return response;
  }

  async ComparePassword(password: string, user: any): Promise<boolean> {
    const isMatch = await bcrypt.compare(password, user.password);
    return isMatch;
  }

  async generateToken(user: any) {
    const token = jwt.sign({ id: user.id }, process.env.JWT_SECRET, {
      expiresIn: process.env.JWT_EXPIRES_IN,
    });
    return token;
  }

  
}
