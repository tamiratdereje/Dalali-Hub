import mongoose from "mongoose";
import { IBaseEntity } from "./BaseEntity";
import * as bcrypt from "bcrypt";


export interface OtpEntity extends IBaseEntity {
    _id: mongoose.Types.ObjectId;
    otp: string;
    user: mongoose.Types.ObjectId;
    expiresAt: Date;
}

let otpSchema = new mongoose.Schema<OtpEntity>(
    {
        otp: { type: String, required: [true, "OTP is required"] },
        user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
        expiresAt: { type: Date, required: [true, "ExpiresAt is required"] },
    },
    { timestamps: true },
);

otpSchema.pre("save", function (next) {
    if (!this.isModified("otp")) {
        return next();
    }
    this.otp = bcrypt.hashSync(this.otp, 10);
    next();
});

otpSchema.methods.toJSON = function () {
    let obj = this.toObject();
    delete obj.user;
    delete obj.expiresAt;
    return obj;
}


export const OtpModel = mongoose.model<OtpEntity>("Otp", otpSchema);