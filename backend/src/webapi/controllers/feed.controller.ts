import { FeedResponseDTO } from "@dtos/FeedResponseDTO";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";
import { JSendResponse } from "@error-custom/JsendResponse";

import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { IRealStateRepository } from "@interfaces/repositories/IRealStateRepository";
import { IVehicleRepository } from "@interfaces/repositories/IVehicleRepository";
import { id } from "date-fns/locale";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";

export class FeedController {
  constructor(
    private realstateRepository: IRealStateRepository,
    private vehicleRepository: IVehicleRepository,
    private _photoRepository: IPhotoRepository
  ) {}
  getAllFeeds = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const feeds: FeedResponseDTO[] = [];
      const realstate = await this.realstateRepository.GetAll();

      for (let curRealstate of realstate) {
        const realstateImageDto: PhotoResponseDTO[] = [];
        const realstateFeed = new FeedResponseDTO(
          curRealstate._id,
          curRealstate.title,
          curRealstate.minPrice,
          curRealstate.maxPrice,
          curRealstate.category,
          curRealstate.seats,
          curRealstate.size,
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
          null
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
        const vehicleFeed = new FeedResponseDTO(
          curVehicle._id,
          null,
          null,
          null,
          curVehicle.category,
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
          null,
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
          curVehicle.condition
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
