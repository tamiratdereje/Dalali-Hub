import { OtpEntity } from "@entities/OtpEntity";
import { IGenericRepository } from "./IGenericRepository";
import mongoose, { ObjectId } from "mongoose";

export interface IOtpRepository extends IGenericRepository<OtpEntity> {
    GetOtpByUserId(userId: mongoose.Types.ObjectId): Promise<OtpEntity>;
}