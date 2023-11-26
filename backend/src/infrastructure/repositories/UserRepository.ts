import { LoginDTO } from "@dtos/loginDTO";
import { LoginResponseDTO } from "@dtos/loginResponseDTO";
import { UserEntity } from "@entities/UserEntity";
import { BadRequestError } from "@error-custom/BadRequestError";
import { IUserRepository } from "@interfaces/repositories/IUserRepository";
import { IOtpService } from "@interfaces/services/IOtpService";
import * as bcrypt from "bcrypt";
import * as jwt from "jsonwebtoken";
import mongoose from "mongoose";
import { GenericRepository } from "./GenericRepository";
import { UnAuthorizedError } from "@error-custom/UnAuthorizedError";

export class UserRepository
  extends GenericRepository<UserEntity>
  implements IUserRepository
{
  constructor(
    schema: mongoose.Model<UserEntity>,
  ) {
    super(schema);
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

  async GetByEmail(email: string): Promise<UserEntity> {
    const query = { email: email };
    const user = await this._schema.findOne(query);
    if (!user) {
      throw new Error("User not found with this email");
    }
    return user;
  }

  async GetByPhone(phone: string): Promise<UserEntity> {
    const query = { phone: phone };
    const user = await this._schema.findOne(query);
    if (!user) { throw new Error("User not found with this phone number");}
    return user;
  }

  async userExists(email: string, phone: string): Promise<boolean> {
    const query = { $or: [{ email: email }, { phone: phone }] , isActive: true};
    const user = await this._schema.findOne(query);
    if (user) { return true; }
    return false;
  }

  async activeUserExistsDifferentId(
    email: string,
    phone: string,
    id: mongoose.Types.ObjectId,
  ): Promise<boolean> {
    const query = {
      $or: [{ email: email }, { phone: phone }],
      _id: { $ne: id },
      isActive: true
    };
    const user = await this._schema.findOne(query);
    if (user) { return true; }
    return false;
  }
}
