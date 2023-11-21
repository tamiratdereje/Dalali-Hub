import { Router } from "express";
import { AuthController } from "webapi/controllers/auth.controller";
import { User } from "@entities/UserEntity";
import { UserRepository } from "@repositories/UserRepository";
import { OtpService } from "infrastructure/service/OtpService";
import upload from "config/multer.config";
import { FileUploadService } from "infrastructure/service/FileUploadService";
import { PhotoRepository } from "@repositories/PhotoRepository";
import { Photo } from "@entities/PhotoEntity";
import { MailService } from "infrastructure/service/mail/MailService";
import { OtpRepository } from "@repositories/OtpRepository";
import { OtpModel } from "@entities/OtpEntity";
import { Token } from '@entities/TokenEntity';
import { TokenRepository } from "@repositories/TokenRepository";


const authRoute = Router();
const mailService = new MailService();
const fileUploadService = new FileUploadService();
const userRepository = new UserRepository(User);
const otpRepository = new  OtpRepository(OtpModel);
const photoRepository = new PhotoRepository(Photo);
const tokenRepository = new TokenRepository(Token);
const otpService = new OtpService(mailService, otpRepository, userRepository);

const authController = new AuthController(
  userRepository,
  photoRepository,
  otpService,
  fileUploadService,
  tokenRepository
);

authRoute.post("/request-otp", authController.requestOtp);
authRoute.post("/signup", authController.signup);
authRoute.post("/login", authController.login);
authRoute.post("/verify-otp", authController.verifyOtp);

export { authRoute };
