import { FeedResponseDTO } from "@dtos/FeedResponseDTO";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { ViewDTO } from "@dtos/ViewDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";
import { UserResponseDTO } from "@dtos/userResponseDTO";
import { RealState } from "@entities/RealStateEntity";
import { View } from "@entities/ViewEntity";
import { JSendResponse } from "@error-custom/JsendResponse";
import { IFavoriteRepository } from "@interfaces/repositories/IFavoriteRepository";

import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { IRealStateRepository } from "@interfaces/repositories/IRealStateRepository";
import { IUserRepository } from "@interfaces/repositories/IUserRepository";
import { IVehicleRepository } from "@interfaces/repositories/IVehicleRepository";
import { IViewRepository } from "@interfaces/repositories/IViewRepository";
import { UserRepository } from "@repositories/UserRepository";
import { id, vi } from "date-fns/locale";
import { RealStateCategory, Status } from "domain/types/types";
import { NextFunction, Request, Response } from "express";
import e = require("express");
import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";

export class FeedController {
  constructor(
    private realstateRepository: IRealStateRepository,
    private vehicleRepository: IVehicleRepository,
    private _photoRepository: IPhotoRepository,
    private _userRepository: IUserRepository,
    private _favoriteRepository: IFavoriteRepository,
    private _viewRepository: IViewRepository
  ) {}
  getPropertyCount = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log("User ID \n\n\n\n\n\n\n\n\n\n\n\n");
      console.log(req.userId);
      console.log("User ID \n\n\n\n\n\n\n\n\n\n\n\n");
      const realstate = await this.realstateRepository.GetAll();
      const vehicle = await this.vehicleRepository.GetAll();
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(vehicle.length + realstate.length));
    }
  );
  getEachPropertyCount = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log("User ID \n\n\n\n\n\n\n\n\n\n\n\n");
      console.log(req.userId);
      console.log("User ID \n\n\n\n\n\n\n\n\n\n\n\n");
      // map through the realstate and vehicle and get the count of each
      // create map of string and number
      // return the map

      var eachItemsCount = new Map<string, number>();

      const realstates = await this.realstateRepository.GetAll();
      const vehicle = await this.vehicleRepository.GetAll();

      for (let curRealstate of realstates) {
        if (eachItemsCount.has(curRealstate.category)) {
          eachItemsCount.set(
            curRealstate.category,
            eachItemsCount.get(curRealstate.category) + 1
          );
        } else {
          eachItemsCount.set(curRealstate.category, 1);
        }
      }
      eachItemsCount.set("Vehicle", vehicle.length);
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(eachItemsCount));
    }
  );

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
          owner.location,
          ownerPhotos,
          owner.role
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
          curRealstate.price,
          null,
          user,
          curRealstate.numberOfViews,
          favorite ? true : false,
          curRealstate.status,
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
          owner.location,
          ownerPhotos,
          owner.role
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
      const view = await this._viewRepository.GetMyView(
        Object(req.userId),
        Object(propertyId)
      );
      const viewDto = new ViewDTO({ property: propertyId, user: req.userId });

      if (!view) {
        console.log("whahahahahahahha");
        const viewEntity = new View(viewDto);
        await this._viewRepository.Create(viewEntity);
      }
      console.log("whahahahahahahha");
      console.log(view);

      const feed: FeedResponseDTO = null;
      const realstate = await this.realstateRepository.GetById(
        Object(propertyId)
      );

      if (realstate) {
        if (!view) {
          realstate.numberOfViews = Number(realstate.numberOfViews) + 1;
          console.log(realstate.numberOfViews, "realstate numberOfViews");
          await this.realstateRepository.Update(realstate._id, realstate);
        }
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
          owner.location,
          ownerPhotos,
          owner.role
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
          realstate.price,
          null,
          user,
          realstate.numberOfViews,
          favorite ? true : false,
          realstate.status,
          null
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

        console.log(realstateDto);
        res
          .status(StatusCodes.OK)
          .json(new JSendResponse().success(realstateDto));
      } else {
        const vehicle = await this.vehicleRepository.GetById(
          Object(propertyId)
        );
        if (!view) {
          vehicle.numberOfViews = Number(vehicle.numberOfViews) + 1;
          await this.vehicleRepository.Update(vehicle._id, vehicle);
        }
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
          owner.location,
          ownerPhotos,
          owner.role
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
          favorite ? true : false,
          vehicle.status,
          null
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
  updateNumberOfViews = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const propertyId = req.params.id;
      const view = await this._viewRepository.GetMyView(
        Object(req.userId),
        Object(propertyId)
      );
      const viewDto = new ViewDTO({ property: propertyId, user: req.userId });

      if (!view) {
        const viewEntity = new View(viewDto);
        await this._viewRepository.Create(viewEntity);
        const realstate = await this.realstateRepository.GetById(
          Object(propertyId)
        );
        if (realstate) {
          realstate.numberOfViews = Number(realstate.numberOfViews) + 1;
          await this.realstateRepository.Update(realstate._id, realstate);
        } else {
          const vehicle = await this.vehicleRepository.GetById(
            Object(propertyId)
          );
          vehicle.numberOfViews = Number(vehicle.numberOfViews) + 1;
          await this.vehicleRepository.Update(vehicle._id, vehicle);
        }
      }
    }
  );

  getMyStatistics = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log("dfrdfedfe gegfe");
      let totalNumOfView: number = 0;
      let totalListing: number = 0;
      let numberOfSuccedListing: number = 0;
      let numberOfFavorite: number = 0;

      const userId = req.userId;
      console.log(userId);
      const realstates = await this.realstateRepository.GetByFilter(
        { owner: userId },
        req.sort,
        req.populate
      );
      const vehicles = await this.vehicleRepository.GetByFilter(
        { owner: userId },
        req.populate
      );

      console.log(realstates, vehicles);
      realstates.map((e) => {
        totalNumOfView += e.numberOfViews.valueOf();
      });
      vehicles.map((e) => {
        totalNumOfView += e.numberOfViews.valueOf();
      });
      totalListing = realstates.length + vehicles.length;
      numberOfSuccedListing =
        realstates.filter((e) => e.isApproved == true).length +
        vehicles.filter((e) => e.isApproved == true).length;
      const myFavorites = await this._favoriteRepository.GetMyFavorites(
        Object(req.userId)
      );
      numberOfFavorite = myFavorites.length;
      console.log(
        totalNumOfView,
        totalListing,
        numberOfSuccedListing,
        numberOfFavorite
      );

      res.status(StatusCodes.OK).json(
        new JSendResponse().success({
          totalNumOfView,
          totalListing,
          numberOfSuccedListing,
          numberOfFavorite,
        })
      );
    }
  );

  getAllMyListing = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const userId = req.userId;
      const realstates = await this.realstateRepository.GetByFilter(
        { ...JSON.parse(req.queryString), owner: userId },
        req.sort,
        req.populate
      );
      console.log({ ...JSON.parse(req.queryString), owner: userId });

      const vehicles = await this.vehicleRepository.GetByFilter(
        { ...JSON.parse(req.queryString), owner: userId },
        req.populate
      );

      const feeds: FeedResponseDTO[] = [];

      for (let curRealstate of realstates) {
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
          owner.location,
          ownerPhotos,
          owner.role
        );
        const buyer = await this._userRepository.GetById(curRealstate.boughtBy);
        const buyerPhotos: PhotoResponseDTO[] = [];
        const buyerUser = new UserResponseDTO(
          buyer._id,
          buyer.firstName,
          buyer.middleName,
          buyer.sirName,
          buyer.email,
          buyer.phoneNumber,
          buyer.gender,
          buyer.location,
          buyerPhotos,
          buyer.role
        );
        for (let buyerPhoto of buyer.photos) {
          await this._photoRepository
            .GetById(buyerPhoto)
            .then((returnPhoto) => {
              buyerPhotos.push(
                new PhotoResponseDTO(
                  returnPhoto.publicId,
                  returnPhoto.secureUrl,
                  returnPhoto._id
                )
              );
            });
        }

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
          curRealstate.price,
          null,
          user,
          curRealstate.numberOfViews,
          favorite ? true : false,
          curRealstate.status,
          buyerUser
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

      for (let curVehicle of vehicles) {
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
          owner.location,
          ownerPhotos,
          owner.role
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
        const buyer = await this._userRepository.GetById(curVehicle.boughtBy);
        const buyerPhotos: PhotoResponseDTO[] = [];
        const buyerUser = new UserResponseDTO(
          buyer._id,
          buyer.firstName,
          buyer.middleName,
          buyer.sirName,
          buyer.email,
          buyer.phoneNumber,
          buyer.gender,
          buyer.location,
          buyerPhotos,
          buyer.role
        );
        for (let buyerPhoto of buyer.photos) {
          await this._photoRepository
            .GetById(buyerPhoto)
            .then((returnPhoto) => {
              buyerPhotos.push(
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
          favorite ? true : false,
          curVehicle.status,
          buyerUser
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

  //   {
  //     category(7): [
  //        jan : [5,8,0]
  //        feb:  [status]
  //        mar:  [status]
  //     ]
  //  }
  filterPropertiesByDate = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log("User ID \n\n\n\n\n\n\n\n\n\n\n\n");
      console.log(req.userId);
      console.log("User ID \n\n\n\n\n\n\n\n\n\n\n\n");
      const feeds: FeedResponseDTO[] = [];

      const realstates = await this.realstateRepository
        .GetAll
        // JSON.parse(req.queryString),
        // req.populate
        ();

      // Initialize category map
      const categoryMap: { [key in string]: { [key: string]: number[] } } = {
        [RealStateCategory.HOUSEFORRENT]: {},
        [RealStateCategory.HOUSEFORSELL]: {},
        [RealStateCategory.SHORTSTAYAPRTMENT]: {},
        [RealStateCategory.HALL]: {},
        [RealStateCategory.OFFICE]: {},
        [RealStateCategory.LAND]: {},
      };

      console.log("monthIndex", categoryMap);

      // Initialize months array
      const months: string[] = [
        "Jan",
        "Feb",
        "Mar",
        "Apr",
        "May",
        "Jun",
        "Jul",
        "Aug",
        "Sep",
        "Oct",
        "Nov",
        "Dec",
      ];
      console.log("anoth montindex", months);

      // Populate category map with initial arrays
      for (let category in categoryMap) {
        for (let month of months) {
          categoryMap[category][month] = [0, 0, 0];
        }
      }

      console.log("lenghth of categories", realstates.length);
      // Populate category map and eachItemsByMonth
      for (let curRealstate of realstates) {
        const monthIndex = curRealstate.createdAt.getMonth();
        console.log(
          monthIndex,
          "monthIndex",
          curRealstate.status,
          "status",
          curRealstate.createdAt,
          "createdAt",
          curRealstate.createdAt.getDate(),
          "date",
          curRealstate.createdAt.getMonth(),
          "month",
          curRealstate.createdAt.getFullYear(),
          "year"
        );
        const month = months[monthIndex];
        const category = curRealstate.category;
        console.log(
          curRealstate.status,
          "status",
          curRealstate.category,
          "category",
          month,
          "month"
        );
        const statusIndex = Object.values(Status).indexOf(curRealstate.status);
        if (statusIndex !== -1) {
          categoryMap[category][month][statusIndex]++;
        }
      }

      // Log or use categoryMap as needed
      console.log(categoryMap);

      // Respond with success
      res.status(StatusCodes.OK).json(new JSendResponse().success(categoryMap));
    }
  );
}
