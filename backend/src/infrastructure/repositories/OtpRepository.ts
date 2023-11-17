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
        var query = { userId: userId };
        var otp = await this.schema.findOne(query);
        if (!otp) { throw new Error("Otp not found"); }
        return otp;
    }
    
  }