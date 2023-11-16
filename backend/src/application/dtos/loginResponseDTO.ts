import mongoose from "mongoose";

export class LoginResponseDTO {
  constructor(
    public userId: mongoose.Types.ObjectId,
    public token: string,
  ) {}
}
