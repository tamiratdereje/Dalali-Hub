
import { UserEntity } from "@entities/UserEntity";
import { IUserRepository } from "@interfaces/repositories/IUserRepository";
import * as bcrypt from "bcrypt";
import * as jwt from "jsonwebtoken";
import mongoose from "mongoose";
import { GenericRepository } from "./GenericRepository";
import * as jose from "node-jose";
import { getKeyStore } from "config/create_key_store";
import {toMs} from "ms-typescript";
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
    console.log("GENERATE TOKEN BEGINS")
    var keyStore = await getKeyStore();
    const [key] = keyStore.all({ use: 'sig' })
    
    const opt = { compact: true, jwk: key, fields: { typ: 'jwt' } }
    const payload = JSON.stringify({
      exp: Math.floor((Date.now() + toMs('50d')) / 1000),
      iat: Math.floor(Date.now() / 1000),
      sub: 'test',
      aud: 'dalali-hub-pjszr',
      id: user._id,
    })
    const token = await jose.JWS.createSign(opt, key)
      .update(payload)
      .final()
      return token.toString(); 
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
