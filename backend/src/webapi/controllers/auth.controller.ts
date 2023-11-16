import { LoginDTO } from "@dtos/loginDTO";
import { RequestOtpDTO } from "@dtos/requestOtpDTO";
import { SignUpDTO } from "@dtos/signupDTO";
import { Photo } from "@entities/PhotoEntity";
import { User } from "@entities/UserEntity";
import { JSendResponse } from "@error-custom/JsendResponse";
import { CustomValidationError } from "@error-custom/ValidationError";
import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { IUserRepository } from "@interfaces/repositories/IUserRepository";
import { IFileUploadService } from "@interfaces/services/IFileService";
import { IOtpService } from "@interfaces/services/IOtpService";
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
      const { phoneNumber } = new RequestOtpDTO(req.body);
      const ValidationError = await validate({ phoneNumber });
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }

      await this._otpService.SendOtp(phoneNumber);
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

      const user = new User(userDto);

      //TODO: Add more validations and remove unnecessary files during errors
      if (!req.files)
        throw new CustomValidationError("Profile picture not found");

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

      // Verify OTP
      if (!(await this._otpService.VerifyOtp(userDto.phone, userDto.otp))) {
        res
          .status(StatusCodes.BAD_REQUEST)
          .json(new JSendResponse().fail("Invalid OTP"));
        return;
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
}