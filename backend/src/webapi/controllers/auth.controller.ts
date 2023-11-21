import { LoginDTO } from "@dtos/loginDTO";
import { LoginResponseDTO } from "@dtos/loginResponseDTO";
import { RequestOtpDTO } from "@dtos/requestOtpDTO";
import { ResetPasswordDTO } from "@dtos/resetPasswordDTO";
import { SignUpDTO } from "@dtos/signupDTO";
import { VerifyOtpDTO } from "@dtos/verifyOtpDto";
import { Photo } from "@entities/PhotoEntity";
import { User } from "@entities/UserEntity";
import { BadRequestError } from "@error-custom/BadRequestError";
import { JSendResponse } from "@error-custom/JsendResponse";
import { UnAuthorizedError } from "@error-custom/UnAuthorizedError";
import { CustomValidationError } from "@error-custom/ValidationError";
import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { ITokenRepository } from "@interfaces/repositories/ITokenRepository";
import { IUserRepository } from "@interfaces/repositories/IUserRepository";
import { IFileUploadService } from "@interfaces/services/IFileService";
import { IOtpService, OtpType } from "@interfaces/services/IOtpService";
import { validate } from "class-validator";
import { OtpPurpose } from "domain/types/types";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import mongoose, { mongo } from "mongoose";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";

export class AuthController {
  constructor(
    private _userRepository: IUserRepository,
    private _photoRepository: IPhotoRepository,
    private _otpService: IOtpService,
    private _fileUploadService: IFileUploadService,
    private _tokenRepository: ITokenRepository
  ) {}

  requestOtp = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      // Validate request
      const otpRequest = new RequestOtpDTO(req.body);
      const ValidationError = await validate( otpRequest );
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }
      
      // Get user
      const user = otpRequest.otpType === OtpType.EMAIL ? 
        await this._userRepository.GetByEmail(otpRequest.email) :
        await this._userRepository.GetByPhone(otpRequest.phoneNumber);
      if (!user) { throw new BadRequestError("User not found"); }

      // Send OTP
      await this._otpService.SendOtp(user, otpRequest.otpType as OtpType);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    },
  );

  signup = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      // Validate request
      const userDto = new SignUpDTO(req.body);
      const ValidationError = await validate(userDto);
      if (ValidationError.length > 0) {
        console.log("Signup Validation Error", ValidationError)
        throw CustomValidationError.Instance(ValidationError);
      } 
      
      // check if user already exists
      if (await this._userRepository.userExists(userDto.email, userDto.phoneNumber)) {
        console.log("Signup : User already exists")
        throw new Error("User email or phone already exists");
      }
      
      // Create user
      const user = new User(
        userDto);
        
        // Upload photos
        if (req.files) {
          //TODO: Add more validations and remove unnecessary files during errors
          const profileImages = req.files as Express.Multer.File[];
          const uploadedImages = profileImages.map(async (image, _) => {
            return await this._fileUploadService.uploadFile(image);
          });
    
          await Promise.all(uploadedImages);
    
          for (let uploadedImage of uploadedImages) {
            await uploadedImage.then(async (image) => {
              const photo = new Photo(image);
              await this._photoRepository.Create(photo).then((_) => {
                user.photos.push(photo.id);
              });
            });
          }
      }

      // Save user
      const userCreated = await this._userRepository.Create(user);
      res
        .status(StatusCodes.CREATED)
        .json(new JSendResponse().success(userCreated));
    },
  );

  login = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      // Validate request
      const loginDto = new LoginDTO(req.body);
      const ValidationError = await validate(loginDto);
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }

      // Get user
      const user = await this._userRepository.GetByEmail(loginDto.email);
      if (!user) { throw new BadRequestError("Invalid credentials"); }

      // Check if user is verified
      if (!user.isVerified) { 
        await this._otpService.SendOtp(user, OtpType.EMAIL);
        throw new UnAuthorizedError("User is not verified"); 
      }

      // Check if password matches
      const isMatch = await this._userRepository.ComparePassword(loginDto.password, user);
      if (!isMatch) {throw new BadRequestError("Invalid credentials");}

      // Generate token
      const token = await this._userRepository.generateToken(user);
      const loginResponseDto = new LoginResponseDTO(user._id, token);

      res
        .status(StatusCodes.OK)
        .json(
          new JSendResponse().success(loginResponseDto, "Login Successful"),
        );
    },
  );

  verifyOtp = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      // Validate request
      const verifyOtpDto = new VerifyOtpDTO(req.body);
      const ValidationError = await validate(verifyOtpDto);
      if (ValidationError.length > 0) { throw CustomValidationError.Instance(ValidationError); }

      // Get user
      const user = verifyOtpDto.otpType === OtpType.EMAIL ? 
        await this._userRepository.GetByEmail(verifyOtpDto.email) :
        await this._userRepository.GetByPhone(verifyOtpDto.phoneNumber);
      
      // Check if user exists
      if (!user) { throw new BadRequestError("User not found"); }

      // Verify OTP
      const isVerified = await this._otpService.VerifyOtp(user, verifyOtpDto.otp);
      if (!isVerified) { throw new Error("Invalid OTP"); }

      let token = null;
      // Check otp purpose if reset password generate token
      if (verifyOtpDto.otpPurpose === OtpPurpose.ResetPassword) { 
         token = await this._tokenRepository.createToken(user._id);
      }

      console.log("Token", token)

      // Update user
      user.isVerified = true;
      await this._userRepository.Update(user._id, user);
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(token, "OTP verified successfully"));
    },
  );

  resetPassword = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      // Validate request
      const resetPasswordDto = new ResetPasswordDTO(req.body);
      const ValidationError = await validate(resetPasswordDto);
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }

      // Verify token
      const userId = await this._tokenRepository.verifyToken(resetPasswordDto.resetToken);
      if (!userId) { throw new BadRequestError("Invalid token"); }

      // Get user
      const user = await this._userRepository.GetById(userId);
      if(!user){ throw new BadRequestError("User not found"); }


      // Update user password
      user.password = resetPasswordDto.newPassword;
      await this._userRepository.Update(user._id, user);

      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(null, "Password reset successfully"));
      
    }
  );

  
}
