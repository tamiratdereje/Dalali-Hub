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

export class VehicleController {
  constructor(
    private vehicleRepository: IVehicleRepository,
    private _fileUploadService: IFileUploadService,
    private _photoRepository: IPhotoRepository
  ) {}
  createVehicle = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log(req.body);
      const vehicleDto = new VehicleDTO(JSON.parse(req.body.vehicle));

      console.log(vehicleDto);
      const ValidationError = await validate(vehicleDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      console.log(vehicleDto);

      const vehicle = new Vehicle(vehicleDto);
      console.log("files")
      console.log(req.files)
      console.log("files")
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

      const createdVehicle = await this.vehicleRepository.CreateVehicle(vehicle);
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
          uploadedImages.push(new PhotoResponseDTO(curPhoto.publicId, curPhoto.secureUrl, curPhoto._id));
        });
      }
      const resultVehicle = new VehicleResponseDTO(
        vehicle._id,
        vehicle.make,
        vehicle.model,
        vehicle.year,
        vehicle.color,
        vehicle.vin,
        vehicle.fuelType,
        vehicle.engineSize,
        // new LocationResponseDTO(
        //   vehicle.location.region,
        //   vehicle.location.district,
        //   vehicle.location.ward
        // ),
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
         // vehicle.insuranceDetails.policyNumber,        
      );
      res.status(StatusCodes.OK).json(new JSendResponse().success(resultVehicle));
    }
  );

  getAllVehicle = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(req.advancedResults));
    }
  );

  getVehicleByFilter = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const filter = req.body;
      const Vehicles = await this.vehicleRepository.GetByFilter(filter);
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
      const vehicleDto = new VehicleDTO(req.body);
      const ValidationError = await validate(vehicleDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      const oldVehicle = await this.vehicleRepository.GetById(Object(vehicleId));
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
          uploadedImages.push(new PhotoResponseDTO(curPhoto.publicId, curPhoto.secureUrl, curPhoto._id));
        });
      }
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
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  addVehiclePhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const vehicleId = req.params.id;
      const vehicle = await this.vehicleRepository.GetById(Object(vehicleId));
      if (!vehicle) {
        throw new BadRequestError("Vehicle not found");
      }
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
            });
          });
        }
      }
      await this.vehicleRepository.Update(Object(vehicleId), vehicle);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
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
          uploadedImages.push(new PhotoResponseDTO(curPhoto.publicId, curPhoto.secureUrl, curPhoto._id));
        });
      }
      
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(uploadedImages));
    }
  );
}
