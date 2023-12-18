import { FavoriteDTO } from "@dtos/FavoriteDTO";
import { Favorite } from "@entities/FavoriteEntity";
import { JSendResponse } from "@error-custom/JsendResponse";
import { CustomValidationError } from "@error-custom/ValidationError";
import { IFavoriteRepository } from "@interfaces/repositories/IFavoriteRepository";
import { validate } from "class-validator";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";
import { Types } from "mongoose";
import { FavoriteResponseDTO } from "@dtos/FavoriteResponseDTO";
import { FeedResponseDTO } from "@dtos/FeedResponseDTO";
import { IRealStateRepository } from "@interfaces/repositories/IRealStateRepository";
import { BadRequestError } from "@error-custom/BadRequestError";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";
import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { VehicleResponseDTO } from "@dtos/VehicleResponseDTO";
import { IVehicleRepository } from "@interfaces/repositories/IVehicleRepository";
import { IUserRepository } from "@interfaces/repositories/IUserRepository";
import { UserResponseDTO } from "@dtos/userResponseDTO";
export class FavoriteController {
  constructor(
    private favoriteRepository: IFavoriteRepository,
    private realStateRepository: IRealStateRepository,
    private _photoRepository: IPhotoRepository,
    private vehicleRepository: IVehicleRepository,
    private _userRepository: IUserRepository
  ) {}
  addToFavorite = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log(req.body);
      const favoriteDto = new FavoriteDTO(JSON.parse(req.body.favorite));

      console.log(favoriteDto);
      const ValidationError = await validate(favoriteDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      console.log(favoriteDto);

      const favorite = new Favorite(favoriteDto);

      const createdFavorite = await this.favoriteRepository.Create(favorite);
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(createdFavorite));
    }
  );

  getMyFavorite = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const userId: string = "";
      const favorites = await this.favoriteRepository.GetMyFavorites(
        new Types.ObjectId(userId)
      );

      const favoriteResponse = favorites.map((favorite) => async () => {
        const realstateImageDto: PhotoResponseDTO[] = [];
        const vehicleImageDto: PhotoResponseDTO[] = [];
        let curFeed: FeedResponseDTO;
        const realState = await this.realStateRepository.GetById(
          Object(favorite.property)
        );

        const owner: UserResponseDTO = await this._userRepository.GetById(favorite.user);


        if (realState) {
          curFeed = new FeedResponseDTO(
            realState._id,
            realState.title,
            realState.category,
            realState.seats,
            realState.sizeWidth,
            realState.sizeHeight,
            realState.sizeUnit,
            new LocationResponseDTO(
              realState.location.region,
              realState.location.district,
              realState.location.ward
            ),
            realstateImageDto,
            realState.otherFeatures,
            realState.description,
            realState.isApproved,

            realState.rooms,
            realState.beds,
            realState.baths,
            realState.kitchens,
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
            realState.numberOfViews

          );
          for (let curPhoto of realState.photos) {
            await this._photoRepository
              .GetById(curPhoto)
              .then((returnPhoto) => {
                realstateImageDto.push(
                  new PhotoResponseDTO(
                    returnPhoto.publicId,
                    returnPhoto.secureUrl,
                    returnPhoto._id
                  )
                );
              });
          }
        }
        const vehicle = await this.vehicleRepository.GetById(
          Object(favorite.property)
        );
        if (vehicle) {
          console.log(vehicle);
          curFeed = new FeedResponseDTO(
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
            owner,
            vehicle.numberOfViews
          );
          for (let curPhoto of vehicle.photos) {
            await this._photoRepository
              .GetById(curPhoto)
              .then((returnPhoto) => {
                vehicleImageDto.push(
                  new PhotoResponseDTO(
                    returnPhoto.publicId,
                    returnPhoto.secureUrl,
                    returnPhoto._id
                  )
                );
              });
          }
        }

        if (!realState && !vehicle) {
          throw new BadRequestError("Property not found");
        }

        return new FavoriteResponseDTO(favorite._id, curFeed);
      });

      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(favoriteResponse));
    }
  );

  removeFromFavorite = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const favoriteId = req.params.id;
      const favorite = await this.favoriteRepository.GetById(
        Object(favoriteId)
      );
      if (!favorite) {
        throw new BadRequestError("Favorite not found");
      }
      await this.favoriteRepository.Delete(favorite._id);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );
}
