import { Router } from "express";
import { AuthController } from "webapi/controllers/auth.controller";
import { User } from "@entities/UserEntity";
import { UserRepository } from "@repositories/UserRepository";
import { DummyOtpService } from "infrastructure/service/DummyOtpService";
import upload from "config/multer.config";
import { FileUploadService } from "infrastructure/service/FileUploadService";
import { PhotoRepository } from "@repositories/PhotoRepository";
import { Photo } from "@entities/PhotoEntity";

const authRoute = Router();
const otpService = new DummyOtpService();
const fileUploadService = new FileUploadService();
const userRepository = new UserRepository(User, otpService);
const photoRepository = new PhotoRepository(Photo);

const authController = new AuthController(
  userRepository,
  photoRepository,
  otpService,
  fileUploadService,
);

authRoute.post("/request-otp", authController.requestOtp);
authRoute.post("/signup", upload.array("profile", 6), authController.signup);
authRoute.post("/login", authController.login);

export { authRoute };
