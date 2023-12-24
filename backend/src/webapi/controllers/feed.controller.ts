import { FeedResponseDTO } from "@dtos/FeedResponseDTO";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";
import { UserResponseDTO } from "@dtos/userResponseDTO";
import { JSendResponse } from "@error-custom/JsendResponse";
import { IFavoriteRepository } from "@interfaces/repositories/IFavoriteRepository";

import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { IRealStateRepository } from "@interfaces/repositories/IRealStateRepository";
import { IUserRepository } from "@interfaces/repositories/IUserRepository";
import { IVehicleRepository } from "@interfaces/repositories/IVehicleRepository";
import { UserRepository } from "@repositories/UserRepository";
import { id } from "date-fns/locale";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";

export class FeedController {
  constructor(
    private realstateRepository: IRealStateRepository,
    private vehicleRepository: IVehicleRepository,
    private _photoRepository: IPhotoRepository,
    private _userRepository: IUserRepository,
    private _favoriteRepository: IFavoriteRepository
  ) {}
  getAllFeeds = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log("User ID \n\n\n\n\n\n\n\n\n\n\n\n");
      console.log(req.userId);
      console.log("User ID \n\n\n\n\n\n\n\n\n\n\n\n");
      const feeds: FeedResponseDTO[] = [];
      const realstate = await this.realstateRepository.GetAll();

      for (let curRealstate of realstate) {
        const realstateImageDto: PhotoResponseDTO[] = [];
        const owner = await this._userRepository.GetById(curRealstate.owner);

        const ownerPhotos: PhotoResponseDTO[] = [];
        const user = new UserResponseDTO(
          owner._id,
          owner.firstName,
          owner.middleName,
          owner.sirName,
          owner.email,
          owner.phoneNumber,
          owner.gender,
          owner.region,
          ownerPhotos
        );
        for (let ownerPhoto of owner.photos) {
          await this._photoRepository
            .GetById(ownerPhoto)
            .then((returnPhoto) => {
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
          Object(curRealstate._id)
        );
        const realstateFeed = new FeedResponseDTO(
          curRealstate._id,
          curRealstate.title,
          curRealstate.category,
          curRealstate.seats,
          curRealstate.sizeWidth,
          curRealstate.sizeHeight,
          curRealstate.sizeUnit,
          new LocationResponseDTO(
            curRealstate.location.region,
            curRealstate.location.district,
            curRealstate.location.ward
          ),
          realstateImageDto,
          curRealstate.otherFeatures,
          curRealstate.description,
          curRealstate.isApproved,
          curRealstate.rooms,
          curRealstate.beds,
          curRealstate.baths,
          curRealstate.kitchens,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          user,
          curRealstate.numberOfViews,
          favorite ? true : false
        );

        for (let curPhoto of curRealstate.photos) {
          await this._photoRepository.GetById(curPhoto).then((returnPhoto) => {
            realstateImageDto.push(
              new PhotoResponseDTO(
                returnPhoto.publicId,
                returnPhoto.secureUrl,
                returnPhoto._id
              )
            );
          });
        }
        feeds.push(realstateFeed);
      }

      const vehicle = await this.vehicleRepository.GetAll();
      for (let curVehicle of vehicle) {
        const vehicleImageDto: PhotoResponseDTO[] = [];
        console.log(curVehicle);
        const owner = await this._userRepository.GetById(curVehicle.owner);
        const ownerPhotos: PhotoResponseDTO[] = [];
        const user = new UserResponseDTO(
          owner._id,
          owner.firstName,
          owner.middleName,
          owner.sirName,
          owner.email,
          owner.phoneNumber,
          owner.gender,
          owner.region,
          ownerPhotos
        );
        for (let ownerPhoto of owner.photos) {
          await this._photoRepository
            .GetById(ownerPhoto)
            .then((returnPhoto) => {
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

        const vehicleFeed = new FeedResponseDTO(
          curVehicle._id,
          null,
          curVehicle.category,
          null,
          null,
          null,
          null,
          new LocationResponseDTO(
            curVehicle.location.region,
            curVehicle.location.district,
            curVehicle.location.ward
          ),
          vehicleImageDto,
          null,
          null,
          curVehicle.isApproved,
          null,
          null,
          null,
          null,
          curVehicle.make,
          curVehicle.model,
          curVehicle.year,
          curVehicle.color,
          curVehicle.vin,
          curVehicle.fuelType,
          curVehicle.engineSize,
          curVehicle.transmissionType,
          curVehicle.mileage,
          curVehicle.price,
          curVehicle.condition,
          user,
          curVehicle.numberOfViews,
          favorite ? true : false
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
        feeds.push(vehicleFeed);
      }

      res.status(StatusCodes.OK).json(new JSendResponse().success(feeds));
    }
  );

  getProperty = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log("User ID \n\n\n\n\n\n\n\n\n\n\n\n");
      console.log(req.userId);
      console.log("User ID \n\n\n\n\n\n\n\n\n\n\n\n");
      const propertyId = req.params.id;
      const feed: FeedResponseDTO = null;
      const realstate = await this.realstateRepository.GetById(
        Object(propertyId)
      );

      if (realstate) {
        const realstateImageDto: PhotoResponseDTO[] = [];
        const owner = await this._userRepository.GetById(realstate.owner);

        const ownerPhotos: PhotoResponseDTO[] = [];
        const user = new UserResponseDTO(
          owner._id,
          owner.firstName,
          owner.middleName,
          owner.sirName,
          owner.email,
          owner.phoneNumber,
          owner.gender,
          owner.region,
          ownerPhotos
        );
        for (let ownerPhoto of owner.photos) {
          await this._photoRepository
            .GetById(ownerPhoto)
            .then((returnPhoto) => {
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
          Object(realstate._id)
        );
        const realstateDto = new FeedResponseDTO(
          realstate._id,
          realstate.title,
          realstate.category,
          realstate.seats,
          realstate.sizeWidth,
          realstate.sizeHeight,
          realstate.sizeUnit,
          new LocationResponseDTO(
            realstate.location.region,
            realstate.location.district,
            realstate.location.ward
          ),
          realstateImageDto,
          realstate.otherFeatures,
          realstate.description,
          realstate.isApproved,
          realstate.rooms,
          realstate.beds,
          realstate.baths,
          realstate.kitchens,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          null,
          user,
          realstate.numberOfViews,
          favorite ? true : false
        );

        for (let curPhoto of realstate.photos) {
          await this._photoRepository.GetById(curPhoto).then((returnPhoto) => {
            realstateImageDto.push(
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
          .json(new JSendResponse().success(realstateDto));
      } else {
        const vehicle = await this.vehicleRepository.GetById(
          Object(propertyId)
        );
        const vehicleImageDto: PhotoResponseDTO[] = [];
        console.log(vehicle);
        const owner = await this._userRepository.GetById(vehicle.owner);
        const ownerPhotos: PhotoResponseDTO[] = [];
        const user = new UserResponseDTO(
          owner._id,
          owner.firstName,
          owner.middleName,
          owner.sirName,
          owner.email,
          owner.phoneNumber,
          owner.gender,
          owner.region,
          ownerPhotos
        );
        for (let ownerPhoto of owner.photos) {
          await this._photoRepository
            .GetById(ownerPhoto)
            .then((returnPhoto) => {
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

        const vehicleDto = new FeedResponseDTO(
          vehicle._id,
          null,
          vehicle.category,
          null,
          null,
          null,
          null,
          new LocationResponseDTO(
            vehicle.location.region,
            vehicle.location.district,
            vehicle.location.ward
          ),
          vehicleImageDto,
          null,
          null,
          vehicle.isApproved,
          null,
          null,
          null,
          null,
          vehicle.make,
          vehicle.model,
          vehicle.year,
          vehicle.color,
          vehicle.vin,
          vehicle.fuelType,
          vehicle.engineSize,
          vehicle.transmissionType,
          vehicle.mileage,
          vehicle.price,
          vehicle.condition,
          user,
          vehicle.numberOfViews,
          favorite ? true : false
        );
        for (let curPhoto of vehicle.photos) {
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
        res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(vehicleDto));
      }
    }
  );
}
