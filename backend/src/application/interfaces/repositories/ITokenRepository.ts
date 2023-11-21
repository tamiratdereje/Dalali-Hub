import { OtpEntity } from "@entities/OtpEntity";
import { IGenericRepository } from "./IGenericRepository";
import mongoose, { ObjectId } from "mongoose";
import { TokenEntity } from "@entities/TokenEntity";
import { UserEntity } from "@entities/UserEntity";

type UserId = mongoose.Types.ObjectId

export interface ITokenRepository extends IGenericRepository<TokenEntity> {
    createToken(userId: UserId): Promise<TokenEntity>;
    verifyToken(token: string): Promise<UserId>;
    getTokenByUserId(userId: UserId): Promise<TokenEntity>;
}