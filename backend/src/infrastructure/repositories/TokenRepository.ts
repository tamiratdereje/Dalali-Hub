import { OtpEntity } from '@entities/OtpEntity';
import { GenericRepository } from './GenericRepository';
import { IOtpRepository } from '@interfaces/repositories/IOtpRepository';
import mongoose, { Schema } from 'mongoose';
import { TokenEntity } from '@entities/TokenEntity';
import * as jwt from "jsonwebtoken";
import { ITokenRepository } from '@interfaces/repositories/ITokenRepository';
import { UnAuthorizedError } from '@error-custom/UnAuthorizedError';
import { BadRequestError } from '@error-custom/BadRequestError';


export class TokenRepository
  extends GenericRepository<TokenEntity>
  implements ITokenRepository {

    constructor( private schema: mongoose.Model<TokenEntity> ){ super(schema);
    }
    verifyToken(token: string): Promise<mongoose.Types.ObjectId> {
        let userId = null
        jwt.verify(token, process.env.RESET_TOKEN_SECRET, (err: Error, payload: any) => {
            if (err)
                throw new UnAuthorizedError('Invalid or expired token')
            userId = payload.id
            }
        );
        return userId
        
    }
    async getTokenByUserId(userId: mongoose.Types.ObjectId): Promise<TokenEntity> {
        return await this.schema.findOne({user: userId});  
    }
    
    async createToken(userId: mongoose.Types.ObjectId): Promise<TokenEntity> {
        const generatedToken = jwt.sign({ id: userId }, process.env.RESET_TOKEN_SECRET, {
            expiresIn: process.env.RESET_TOKEN_EXPIRES_IN})
        let existingToken = await this.getTokenByUserId(userId)
        
        // if token exists for current user update otherwise create new
        if (existingToken){
            existingToken.token = generatedToken
            this._schema.updateOne(existingToken._id, existingToken)
        } else{
            existingToken = await this.schema.create({
                user: userId,
                token: generatedToken
            })
        }
        return existingToken;
    }

   
    
  }