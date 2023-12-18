import { FeedResponseDTO } from "@dtos/FeedResponseDTO";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";
import { UserResponseDTO } from "@dtos/userResponseDTO";
import { JSendResponse } from "@error-custom/JsendResponse";

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
    private _userRepository: IUserRepository
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
        const owner: UserResponseDTO = await this._userRepository.GetById(
          curRealstate.owner
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
          owner,
          curRealstate.numberOfViews
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
        const owner: UserResponseDTO = await this._userRepository.GetById(
          curVehicle.owner
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
          owner,
          curVehicle.numberOfViews
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
}
