import { LoginDTO } from "@dtos/loginDTO";
import { LoginResponseDTO } from "@dtos/loginResponseDTO";
import { UserEntity } from "@entities/UserEntity";
import { IGenericRepository } from "@interfaces/repositories/IGenericRepository";
import mongoose from "mongoose";

export interface IUserRepository extends IGenericRepository<UserEntity> {
  Login(loginDTO: LoginDTO): Promise<LoginResponseDTO>;
  GetByEmail(email: string): Promise<UserEntity>;
  GetByPhone(phone: string): Promise<UserEntity>;
  userExists(email: string, phone: string): Promise<boolean>;
  activeUserExistsDifferentId( email: string, phone: string, id: mongoose.Types.ObjectId): Promise<boolean>;
}
