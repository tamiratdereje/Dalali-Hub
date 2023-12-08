import { FeedResponseDTO } from "@dtos/FeedResponseDTO";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";
import { JSendResponse } from "@error-custom/JsendResponse";
import { IHallRepository } from "@interfaces/repositories/IHallRepository";
import { IHouseRepository } from "@interfaces/repositories/IHouseRepository";
import { ILandRepository } from "@interfaces/repositories/ILandRepository";
import { IOfficeRepository } from "@interfaces/repositories/IOfficeRepository";
import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";

export class FeedController {
  constructor(
    private houseRepository: IHouseRepository,
    private hallRepostory: IHallRepository,
    private _photoRepository: IPhotoRepository,
    private _landRepository: ILandRepository,
    private _officeRepository: IOfficeRepository
  ) {}
  getAllFeeds = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const feeds: FeedResponseDTO[] = [];
      const house = await this.houseRepository.GetAll();

      for (let curHouse of house) {
        const houseImageDto: PhotoResponseDTO[] = [];
        const houseFeed = new FeedResponseDTO(
          curHouse._id,
          curHouse.title,
          curHouse.minPrice,
          curHouse.maxPrice,
          curHouse.category,
          null,
          curHouse.size,
          curHouse.sizeUnit,
          new LocationResponseDTO(
            curHouse.location.region,
            curHouse.location.district,
            curHouse.location.ward
          ),
          houseImageDto,
          curHouse.otherFeatures,
          curHouse.description,
          curHouse.isApproved,

          curHouse.rooms,
          curHouse.beds,
          curHouse.baths,
          curHouse.kitchens
        );
        for (let curPhoto of curHouse.photos) {
          await this._photoRepository.GetById(curPhoto).then((returnPhoto) => {
            houseImageDto.push(returnPhoto);
          });
        }
        feeds.push(houseFeed);
      }

      const hall = await this.hallRepostory.GetAll();
      for (let curHall of hall) {
        const hallImageDto: PhotoResponseDTO[] = [];
        const hallFeed = new FeedResponseDTO(
          curHall._id,
          curHall.title,
          curHall.minPrice,
          curHall.maxPrice,
          curHall.category,
          null,
          curHall.size,
          curHall.sizeUnit,
          new LocationResponseDTO(
            curHall.location.region,
            curHall.location.district,
            curHall.location.ward
          ),
          hallImageDto,
          curHall.otherFeatures,
          curHall.description,
          curHall.isApproved,

          null,
          null,
          null,
          null
        );
        for (let curPhoto of curHall.photos) {
          await this._photoRepository.GetById(curPhoto).then((returnPhoto) => {
            hallImageDto.push(returnPhoto);
          });
        }
        feeds.push(hallFeed);
      }
      const lands = await this._landRepository.GetAll();
      for (let curLand of lands) {
        const landImageDto: PhotoResponseDTO[] = [];
        const hallFeed = new FeedResponseDTO(
          curLand._id,
          curLand.title,
          curLand.minPrice,
          curLand.maxPrice,
          curLand.category,
          null,
          curLand.size,
          curLand.sizeUnit,
          new LocationResponseDTO(
            curLand.location.region,
            curLand.location.district,
            curLand.location.ward
          ),
          landImageDto,
          curLand.otherFeatures,
          curLand.description,
          curLand.isApproved,

          null,
          null,
          null,
          null
        );
        for (let curPhoto of curLand.photos) {
          await this._photoRepository.GetById(curPhoto).then((returnPhoto) => {
            landImageDto.push(returnPhoto);
          });
        }
        feeds.push(hallFeed);
      }
      const offices = await this._officeRepository.GetAll();
      for (let curOffices of offices) {
        const landImageDto: PhotoResponseDTO[] = [];
        const officesFeed = new FeedResponseDTO(
          curOffices._id,
          curOffices.title,
          curOffices.minPrice,
          curOffices.maxPrice,
          curOffices.category,
          null,
          curOffices.size,
          curOffices.sizeUnit,
          new LocationResponseDTO(
            curOffices.location.region,
            curOffices.location.district,
            curOffices.location.ward
          ),
          landImageDto,
          curOffices.otherFeatures,
          curOffices.description,
          curOffices.isApproved,

          null,
          null,
          null,
          null
        );
        for (let curPhoto of curOffices.photos) {
          await this._photoRepository.GetById(curPhoto).then((returnPhoto) => {
            landImageDto.push(returnPhoto);
          });
        }
        feeds.push(officesFeed);
      }
      res.status(StatusCodes.OK).json(new JSendResponse().success(feeds));
    }
  );
}
