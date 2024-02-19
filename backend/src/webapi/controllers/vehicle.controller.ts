import { VehicleDTO } from "@dtos/VehicleDTO";
import { VehicleResponseDTO } from "@dtos/VehicleResponseDTO";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";

import { Photo } from "@entities/PhotoEntity";
import { BadRequestError } from "@error-custom/BadRequestError";
import { JSendResponse } from "@error-custom/JsendResponse";
import { CustomValidationError } from "@error-custom/ValidationError";
import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { IFileUploadService } from "@interfaces/services/IFileService";
import { validate } from "class-validator";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";
import { IVehicleRepository } from "@interfaces/repositories/IVehicleRepository";
import { Vehicle } from "@entities/VehicleEntity";
import { UserRepository } from "@repositories/UserRepository";
import { UserResponseDTO } from "@dtos/userResponseDTO";
import { IUserRepository } from "@interfaces/repositories/IUserRepository";
import { IFavoriteRepository } from "@interfaces/repositories/IFavoriteRepository";

export class VehicleController {
  constructor(
    private vehicleRepository: IVehicleRepository,
    private _fileUploadService: IFileUploadService,
    private _photoRepository: IPhotoRepository,
    private _userRepository: IUserRepository,
    private _favoriteRepository: IFavoriteRepository
  ) {}
  createVehicle = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log(req.body);
      req.body.userId = req.userId;
      let tempVehicle = JSON.parse(req.body.vehicle);
      tempVehicle.owner = req.userId;

      const vehicleDto = new VehicleDTO(tempVehicle);

      console.log(vehicleDto);
      const ValidationError = await validate(vehicleDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      console.log(vehicleDto);

      const vehicle = new Vehicle(vehicleDto);
      console.log("files");
      console.log(req.files);
      console.log("files");
      // Upload photos
      if (req.files) {
        //TODO: Add more validations and remove unnecessary files during errors
        const vehicleImages = req.files as Express.Multer.File[];
        const uploadedImages = vehicleImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              vehicle.photos.push(photo.id);
            });
          });
        }
      }

      const createdVehicle =
        await this.vehicleRepository.CreateVehicle(vehicle);
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(createdVehicle));
    }
  );
  getVehicleById = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const vehicleId = req.params.id;

      const vehicle = await this.vehicleRepository.GetById(Object(vehicleId));

      if (!vehicle) {
        throw new BadRequestError("Vehicle not found");
      }
      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of vehicle.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(
            new PhotoResponseDTO(
              curPhoto.publicId,
              curPhoto.secureUrl,
              curPhoto._id
            )
          );
        });
      }
      const owner = await this._userRepository.GetById(
        vehicle.owner
      );
      const ownerPhotos: PhotoResponseDTO[] = [];
        const user = new UserResponseDTO(
          owner._id,
          owner.firstName,
          owner.middleName,
          owner.sirName,
          owner.email,
          owner.phoneNumber,
          owner.gender,
          owner.location,
          ownerPhotos,
          owner.role
        );
        for (let ownerPhoto of owner.photos) {
          await this._photoRepository.GetById(ownerPhoto).then((returnPhoto) => {
            ownerPhotos.push(
              new PhotoResponseDTO(
                returnPhoto.publicId,
                returnPhoto.secureUrl,
                returnPhoto._id
              )
            );
          });
        }
      
      const favorite = await this._favoriteRepository.GetMyFavorite(
        Object(req.userId),
         Object(vehicle._id)
       );

      const resultVehicle = new VehicleResponseDTO(
        vehicle._id,
        vehicle.make,
        vehicle.model,
        vehicle.year,
        vehicle.color,
        vehicle.vin,
        vehicle.fuelType,
        vehicle.engineSize,
        uploadedImages,
        new LocationResponseDTO(
          vehicle.location.region,
          vehicle.location.district,
          vehicle.location.ward
        ),
        vehicle.transmissionType,
        vehicle.mileage,
        vehicle.price,
        vehicle.condition,
        vehicle.category,
        vehicle.isApproved,
        user,
        vehicle.numberOfViews,
        favorite ? true : false,
        vehicle.status,
        null
        // vehicle.insuranceDetails.policyNumber,
      );
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(resultVehicle));
    }
  );

  getAllVehicle = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const vehicle = await this.vehicleRepository.GetByFilter(
        JSON.parse(req.queryString),
        req.populate
      );
      const vehicles: VehicleResponseDTO[] = [];
      for (let curVehicle of vehicle) {
        const vehicleImageDto: PhotoResponseDTO[] = [];
        console.log(curVehicle);
        const owner = await this._userRepository.GetById(
          curVehicle.owner
        );

        const ownerPhotos: PhotoResponseDTO[] = [];
        const user = new UserResponseDTO(
          owner._id,
          owner.firstName,
          owner.middleName,
          owner.sirName,
          owner.email,
          owner.phoneNumber,
          owner.gender,
          owner.location,
          ownerPhotos,
          owner.role
        );
        for (let ownerPhoto of owner.photos) {
          await this._photoRepository.GetById(ownerPhoto).then((returnPhoto) => {
            ownerPhotos.push(
              new PhotoResponseDTO(
                returnPhoto.publicId,
                returnPhoto.secureUrl,
                returnPhoto._id
              )
            );
          });
        }
        
        const favorite = await this._favoriteRepository.GetMyFavorite(
          Object(req.userId),
           Object(curVehicle._id)
         );

        const vehicleDTO = new VehicleResponseDTO(
          curVehicle._id,
          curVehicle.make,
          curVehicle.model,
          curVehicle.year,
          curVehicle.color,
          curVehicle.vin,
          curVehicle.fuelType,
          curVehicle.engineSize,
          vehicleImageDto,

          new LocationResponseDTO(
            curVehicle.location.region,
            curVehicle.location.district,
            curVehicle.location.ward
          ),
          curVehicle.transmissionType,
          curVehicle.mileage,
          curVehicle.price,
          curVehicle.condition,
          curVehicle.category,
          curVehicle.isApproved,
          user,
          curVehicle.numberOfViews,
          favorite ? true : false,
          curVehicle.status,
          null
        );
        for (let curPhoto of curVehicle.photos) {
          await this._photoRepository.GetById(curPhoto).then((returnPhoto) => {
            vehicleImageDto.push(
              new PhotoResponseDTO(
                returnPhoto.publicId,
                returnPhoto.secureUrl,
                returnPhoto._id
              )
            );
          });
        }
        vehicles.push(vehicleDTO);
      }
      res.status(StatusCodes.OK).json(new JSendResponse().success(vehicles));
    }
  );

  getVehicleByFilter = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const filter = req.body;
      const Vehicles = await this.vehicleRepository.GetByFilter(
        req.body,
        req.populate
      );
      res.status(StatusCodes.OK).json(new JSendResponse().success(Vehicles));
    }
  );

  deleteVehicle = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const vehicleId = req.params.id;
      const vehicle = await this.vehicleRepository.GetById(Object(vehicleId));
      if (!vehicle) {
        throw new BadRequestError("Vehicle not found");
      }
      await this.vehicleRepository.Delete(vehicle._id);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  updateVehicle = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const vehicleId = req.params.id;
      console.log(req.body);
      console.log(typeof req.body);

      let tempVehicle = req.body;

      console.log(tempVehicle);
      tempVehicle.owner = req.userId;

      const vehicleDto = new VehicleDTO(tempVehicle);
      const ValidationError = await validate(vehicleDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      const oldVehicle = await this.vehicleRepository.GetById(
        Object(vehicleId)
      );
      if (!oldVehicle) {
        throw new BadRequestError("Vehicle not found");
      }

      const vehicle = new Vehicle(vehicleDto);
      vehicle.id = oldVehicle._id;
      vehicle.photos = oldVehicle.photos;
      console.log(vehicle);

      const updatedVehicle = await this.vehicleRepository.Update(
        Object(vehicleId),
        vehicle
      );

      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of vehicle.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(
            new PhotoResponseDTO(
              curPhoto.publicId,
              curPhoto.secureUrl,
              curPhoto._id
            )
          );
        });
      }
      const owner = await this._userRepository.GetById(
        updatedVehicle.owner
      );
      const ownerPhotos: PhotoResponseDTO[] = [];
        const user = new UserResponseDTO(
          owner._id,
          owner.firstName,
          owner.middleName,
          owner.sirName,
          owner.email,
          owner.phoneNumber,
          owner.gender,
          owner.location,
          ownerPhotos,
          owner.role
        );
        for (let ownerPhoto of owner.photos) {
          await this._photoRepository.GetById(ownerPhoto).then((returnPhoto) => {
            ownerPhotos.push(
              new PhotoResponseDTO(
                returnPhoto.publicId,
                returnPhoto.secureUrl,
                returnPhoto._id
              )
            );
          });
        }

      
      const favorite = await this._favoriteRepository.GetMyFavorite(
        Object(req.userId),
         Object(updatedVehicle._id)
       );

      const resultVehicle = new VehicleResponseDTO(
        updatedVehicle._id,
        updatedVehicle.make,
        updatedVehicle.model,
        updatedVehicle.year,
        updatedVehicle.color,
        updatedVehicle.vin,
        updatedVehicle.fuelType,
        updatedVehicle.engineSize,
        uploadedImages,
        new LocationResponseDTO(
          updatedVehicle.location.region,
          updatedVehicle.location.district,
          updatedVehicle.location.ward
        ),
        updatedVehicle.transmissionType,
        updatedVehicle.mileage,
        updatedVehicle.price,
        updatedVehicle.condition,
        updatedVehicle.category,
        updatedVehicle.isApproved,
        user,
        updatedVehicle.numberOfViews,
        favorite ? true : false,
        updatedVehicle.status,
        null
        // updatedVehicle.insuranceDetails.policyNumber,
      );

      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(resultVehicle));
    }
  );

  deleteVehiclePhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const vehicleId = req.params.id;
      const photoId = req.params.photoId;
      const vehicle = await this.vehicleRepository.GetById(Object(vehicleId));
      if (!vehicle) {
        throw new BadRequestError("Vehicle not found");
      }
      
      const photo = await this._photoRepository.GetById(Object(photoId));
      if (!photo) {
        throw new BadRequestError("Photo not found");
      }
      vehicle.photos = vehicle.photos.filter((photo) => {
        console.log("photo start");
        console.log(photo._id.valueOf());
        console.log(Object(photoId));
        console.log("photo end");
        return photo._id.valueOf() !== photoId.valueOf();
      });

      console.log(vehicle.photos);
      await this.vehicleRepository.Update(Object(vehicleId), vehicle);
      await this._photoRepository.Delete(Object(photoId));
      const deletedPhoto = new PhotoResponseDTO(
        photo.publicId,
        photo.secureUrl,
        photo._id
      );
      res.status(StatusCodes.OK).json(new JSendResponse().success(deletedPhoto));
    }
  );

  addVehiclePhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const vehicleId = req.params.id;
      const vehicle = await this.vehicleRepository.GetById(Object(vehicleId));
      if (!vehicle) {
        throw new BadRequestError("Vehicle not found");
      }
      const photoResponseDTOs: PhotoResponseDTO[] = [];
      if (req.files) {
        const vehicleImages = req.files as Express.Multer.File[];
        const uploadedImages = vehicleImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              vehicle.photos.push(photo.id);
              photoResponseDTOs.push(
                new PhotoResponseDTO(photo.publicId, photo.secureUrl, photo._id)
              );
            });
          });
        }
      }
      await this.vehicleRepository.Update(Object(vehicleId), vehicle);
      res.status(StatusCodes.OK).json(new JSendResponse().success(photoResponseDTOs));
    }
  );

  getVehiclePhotos = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const vehicleId = req.params.id;
      const vehicle = await this.vehicleRepository.GetById(Object(vehicleId));
      if (!vehicle) {
        throw new BadRequestError("Vehicle not found");
      }

      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of vehicle.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(
            new PhotoResponseDTO(
              curPhoto.publicId,
              curPhoto.secureUrl,
              curPhoto._id
            )
          );
        });
      }

      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(uploadedImages));
    }
  );
}
