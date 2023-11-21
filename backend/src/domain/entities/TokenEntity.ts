import mongoose from "mongoose";
import { IBaseEntity } from "./BaseEntity";



export interface TokenEntity extends IBaseEntity {
    token: string;
    user: mongoose.Types.ObjectId;
    expiresAt: Date;
}

const tokenSchema = new mongoose.Schema<TokenEntity>(
    {
        token: { type: String, required: [true, "Token is required"] },
        user: { type: mongoose.Schema.Types.ObjectId, ref: "User" },
    },
    { timestamps: true },
);

tokenSchema.methods.toJSON = function () {
    let obj = this.toObject();
    delete obj.user;
    return obj;
}

export const Token = mongoose.model<TokenEntity>("Token", tokenSchema);
