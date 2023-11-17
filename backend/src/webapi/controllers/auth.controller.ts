import { LoginDTO } from "@dtos/loginDTO";
import { RequestOtpDTO } from "@dtos/requestOtpDTO";
import { ResetPasswordDTO } from "@dtos/resetPasswordDTO";
import { SignUpDTO } from "@dtos/signupDTO";
import { VerifyOtpDTO } from "@dtos/verifyOtpDto";
import { Photo } from "@entities/PhotoEntity";
import { User } from "@entities/UserEntity";
import { BadRequestError } from "@error-custom/BadRequestError";
import { JSendResponse } from "@error-custom/JsendResponse";
import { CustomValidationError } from "@error-custom/ValidationError";
import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { IUserRepository } from "@interfaces/repositories/IUserRepository";
import { IFileUploadService } from "@interfaces/services/IFileService";
import { IOtpService, OtpType } from "@interfaces/services/IOtpService";
import { validate } from "class-validator";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";

export class AuthController {
  constructor(
    private _userRepository: IUserRepository,
    private _photoRepository: IPhotoRepository,
    private _otpService: IOtpService,
    private _fileUploadService: IFileUploadService,
  ) {}

  requestOtp = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const otpRequest = new RequestOtpDTO(req.body);
      const ValidationError = await validate( otpRequest );
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }
      const user = otpRequest.otpType === OtpType.EMAIL ? 
        await this._userRepository.GetByEmail(otpRequest.email) :
        await this._userRepository.GetByPhone(otpRequest.phoneNumber);

      await this._otpService.SendOtp(user, otpRequest.otpType as OtpType);
      res.status(StatusCodes.OK).json(new JSendResponse().success(null));
    },
  );

  signup = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const userDto = new SignUpDTO(req.body);
      const ValidationError = await validate(userDto);
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      } 

      // check if user already exists
      if (await this._userRepository.userExists(userDto.email, userDto.phoneNumber)) {
        throw new Error("User email or phone already exists");
      }
      

      const user = new User(userDto);
      //TODO: Add more validations and remove unnecessary files during errors
      if (req.files) {

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

      const userCreated = await this._userRepository.Create(user);
      res
        .status(StatusCodes.CREATED)
        .json(new JSendResponse().success(userCreated));
    },
  );

  login = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const loginDto = new LoginDTO(req.body);
      const ValidationError = await validate(loginDto);
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }

      // Login User
      const loginResponseDto = await this._userRepository.Login(loginDto);
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

      // Verify OTP
      const isVerified = await this._otpService.VerifyOtp(user, verifyOtpDto.otp);
      if (!isVerified) { throw new Error("Invalid OTP"); }

      // Update user
      user.isVerified = true;
      await this._userRepository.Update(user._id, user);
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(null, "OTP verified successfully"));
    },
  );

  resetPassword = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      var resetPasswordDto = new ResetPasswordDTO(req.body);
      const ValidationError = await validate(resetPasswordDto);
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }

      // Get user
      const user = resetPasswordDto.otpType === OtpType.EMAIL ?
        await this._userRepository.GetByEmail(resetPasswordDto.email) :
        await this._userRepository.GetByPhone(resetPasswordDto.phoneNumber);
      if(!user){ throw new BadRequestError("User not found"); }

      // Verify OTP
      const isVerified = await this._otpService.VerifyOtp(user, resetPasswordDto.otp);
      if (!isVerified) { throw new BadRequestError("Invalid OTP"); }

      // Update user password
      user.password = resetPasswordDto.newPassword;

      // Save user
      await this._userRepository.Update(user._id, user);

      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(null, "Password reset successfully"));
      
    }
  );
}
