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
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";
import * as bcrypt from "bcrypt";
import { UpdateUserDTO } from "@dtos/UpdateUserDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";
import { UserResponseDTO } from "@dtos/userResponseDTO";

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
      const ValidationError = await validate(otpRequest);
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }

      // Get user
      const user =
        otpRequest.otpType === OtpType.EMAIL
          ? await this._userRepository.GetByEmail(otpRequest.email)
          : await this._userRepository.GetByPhone(otpRequest.phoneNumber);
      if (!user) {
        throw new BadRequestError("User not found");
      }

      // Send OTP
      await this._otpService.SendOtp(user, otpRequest.otpType as OtpType);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  signup = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      // Validate request
      const userDto = new SignUpDTO(req.body);
      const ValidationError = await validate(userDto);
      if (ValidationError.length > 0) {
        console.log("Signup Validation Error", ValidationError);
        throw CustomValidationError.Instance(ValidationError);
      }

      // check if user already exists
      if (
        await this._userRepository.userExists(
          userDto.email,
          userDto.phoneNumber
        )
      ) {
        console.log("Signup : User already exists");
        throw new Error("User email or phone already exists");
      }

      // Create user
      const user = new User(userDto);

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
    }
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
      if (!user) {
        throw new BadRequestError("Invalid credentials");
      }

      // Check if user is verified
      if (!user.isVerified) {
        await this._otpService.SendOtp(user, OtpType.EMAIL);
        throw new UnAuthorizedError("User is not verified");
      }

      // Check if password matches
      const isMatch = await this._userRepository.ComparePassword(
        loginDto.password,
        user
      );
      if (!isMatch) {
        throw new BadRequestError("Invalid credentials");
      }

      // Generate token
      const token = await this._userRepository.generateToken(user);
      const loginResponseDto = new LoginResponseDTO(user._id, token);

      res
        .status(StatusCodes.OK)
        .json(
          new JSendResponse().success(loginResponseDto, "Login Successful")
        );
    }
  );

  verifyOtp = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      // Validate request
      const verifyOtpDto = new VerifyOtpDTO(req.body);
      const ValidationError = await validate(verifyOtpDto);
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }

      // Get user
      const user =
        verifyOtpDto.otpType === OtpType.EMAIL
          ? await this._userRepository.GetByEmail(verifyOtpDto.email)
          : await this._userRepository.GetByPhone(verifyOtpDto.phoneNumber);

      // Check if user exists
      if (!user) {
        throw new BadRequestError("User not found");
      }

      // Verify OTP
      const isVerified = await this._otpService.VerifyOtp(
        user,
        verifyOtpDto.otp
      );
      if (!isVerified) {
        throw new Error("Invalid OTP");
      }

      let token = null;
      // Check otp purpose if reset password generate token
      if (verifyOtpDto.otpPurpose === OtpPurpose.ResetPassword) {
        token = await this._tokenRepository.createToken(user._id);
      }

      console.log("Token", token);

      // Update user
      user.isVerified = true;
      await this._userRepository.Update(user._id, user);
      res
        .status(StatusCodes.OK)
        .json(
          new JSendResponse().success(token ?? {}, "OTP verified successfully")
        );
    }
  );

  resetPassword = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      // Validate request
      console.log("Reset Password Body : ", req.body);
      const resetPasswordDto = new ResetPasswordDTO(req.body);
      const ValidationError = await validate(resetPasswordDto);
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }

      // Verify token
      const userId = await this._tokenRepository.verifyToken(
        resetPasswordDto.resetToken
      );

      if (!userId) {
        throw new UnAuthorizedError("Your token has expired!");
      }

      // Get user
      const user = await this._userRepository.GetById(userId);
      if (!user) {
        throw new BadRequestError("User not found");
      }

      // Update user password
      user.password = bcrypt.hashSync(resetPasswordDto.newPassword, 10);
      await this._userRepository.Update(user._id, user);

      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success({}, "Password reset successfully"));
    }
  );

  updateProfile = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log(req.body);
      // Validate request
      const userDto = new UpdateUserDTO(req.body);
      const ValidationError = await validate(userDto);
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }

      const oldUser = await this._userRepository.GetById(Object(req.userId));
      // check if user already exists
      if (!oldUser) {
        throw new Error("User email or phone already exists");
      }

      // Create user to be updated
      const user = new User(userDto);

      user._id = oldUser._id;
      user.photos = oldUser.photos;

      const updatedUser = await this._userRepository.Update(user._id, user);

      const updatedUserPhotos: PhotoResponseDTO[] = [];
      const userResponseDto = new UserResponseDTO(
        updatedUser._id,
        updatedUser.firstName,
        updatedUser.middleName,
        updatedUser.sirName,
        updatedUser.email,
        updatedUser.phoneNumber,
        updatedUser.gender,
        updatedUser.region,
        updatedUserPhotos
      );
      for (let updatedUserPhoto of updatedUser.photos) {
        await this._photoRepository
          .GetById(updatedUserPhoto)
          .then((returnPhoto) => {
            updatedUserPhotos.push(
              new PhotoResponseDTO(
                returnPhoto.publicId,
                returnPhoto.secureUrl,
                returnPhoto._id
              )
            );
          });
      }

      res
        .status(StatusCodes.CREATED)
        .json(
          new JSendResponse().success(
            userResponseDto,
            "Profile updated successfully"
          )
        );
    }
  );

  // update profile picture
  updateProfilePicture = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const oldUser = await this._userRepository.GetById(Object(req.userId));
      // check if user already exists
      if (!oldUser) {
        throw new Error("User email or phone already exists");
      }

      const user = new User(oldUser);
      user.photos = [];

      const uploadedImagesResponse: PhotoResponseDTO[] = [];
      if (req.files) {
        const userImages = req.files as Express.Multer.File[];
        const uploadedImages = userImages.map(async (image, _) => {
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

      const oldUserImages = oldUser.photos;
      for (let e of oldUserImages) {
        await this._photoRepository.GetById(e).then((curPhoto) => async () => {
          this._photoRepository.Delete(curPhoto._id),
            await this._fileUploadService.deleteFile(curPhoto.secureUrl);
        });
      }

      const updatedUser = await this._userRepository.Update(user._id, user);

      const updatedUserPhotos: PhotoResponseDTO[] = [];
      const userDto = new UserResponseDTO(
        updatedUser._id,
        updatedUser.firstName,
        updatedUser.middleName,
        updatedUser.sirName,
        updatedUser.email,
        updatedUser.phoneNumber,
        updatedUser.gender,
        updatedUser.region,
        updatedUserPhotos
      );
      for (let updatedUserPhoto of updatedUser.photos) {
        await this._photoRepository
          .GetById(updatedUserPhoto)
          .then((returnPhoto) => {
            updatedUserPhotos.push(
              new PhotoResponseDTO(
                returnPhoto.publicId,
                returnPhoto.secureUrl,
                returnPhoto._id
              )
            );
          });
      }

      res
        .status(StatusCodes.CREATED)
        .json(
          new JSendResponse().success(userDto, "Profile updated successfully")
        );
    }
  );
  getMyProfile = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const user = await this._userRepository.GetById(Object(req.userId));
      if (!user) {
        throw new Error("User not found");
      }

      const userPhotos: PhotoResponseDTO[] = [];
      const userDto = new UserResponseDTO(
        user._id,
        user.firstName,
        user.middleName,
        user.sirName,
        user.email,
        user.phoneNumber,
        user.gender,
        user.region,
        userPhotos
      );
      for (let userPhoto of user.photos) {
        await this._photoRepository.GetById(userPhoto).then((returnPhoto) => {
          userPhotos.push(
            new PhotoResponseDTO(
              returnPhoto.publicId,
              returnPhoto.secureUrl,
              returnPhoto._id
            )
          );
        });
      }

      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(userDto, "User found"));
    }
  );
  getOtherUserProfile = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const user = await this._userRepository.GetById(Object(req.params.id));
      if (!user) {
        throw new Error("User not found");
      }

      const userPhotos: PhotoResponseDTO[] = [];
      const userDto = new UserResponseDTO(
        user._id,
        user.firstName,
        user.middleName,
        user.sirName,
        user.email,
        user.phoneNumber,
        user.gender,
        user.region,
        userPhotos
      );
      for (let userPhoto of user.photos) {
        await this._photoRepository.GetById(userPhoto).then((returnPhoto) => {
          userPhotos.push(
            new PhotoResponseDTO(
              returnPhoto.publicId,
              returnPhoto.secureUrl,
              returnPhoto._id
            )
          );
        });
      }

      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(userDto, "User found"));
    }
  );
}
