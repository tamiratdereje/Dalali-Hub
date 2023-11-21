import { OtpEntity } from '@entities/OtpEntity';
import { GenericRepository } from './GenericRepository';
import { IOtpRepository } from '@interfaces/repositories/IOtpRepository';
import mongoose, { Schema } from 'mongoose';


export class OtpRepository
  extends GenericRepository<OtpEntity>
  implements IOtpRepository {

    constructor( private schema: mongoose.Model<OtpEntity> ){ super(schema);
    }
    
    async GetOtpByUserId(userId: mongoose.Types.ObjectId): Promise<OtpEntity> {
        var query = { user: userId };
        var otp = await this._schema.findOne(query);
        return otp;
    }
    
  }