import { HouseDTO } from "@dtos/HouseDTO";
import { HallEntity } from "@entities/HallEntity";
import { House, HouseEntity } from "@entities/HouseEntity";
import { LandEntity } from "@entities/LandEntity";
import { OfficeEntity } from "@entities/OfficeEntity";
import { Photo } from "@entities/PhotoEntity";
import { BadRequestError } from "@error-custom/BadRequestError";
import { JSendResponse } from "@error-custom/JsendResponse";
import { CustomValidationError } from "@error-custom/ValidationError";
import { IHallRepository } from "@interfaces/repositories/IHallRepository";
import { IHouseRepository } from "@interfaces/repositories/IHouseRepository";
import { ILandRepository } from "@interfaces/repositories/ILandRepository";
import { IOfficeRepository } from "@interfaces/repositories/IOfficeRepository";
import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { IFileUploadService } from "@interfaces/services/IFileService";
import { validate } from "class-validator";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";

export class HouseController {
  constructor(
    private houseRepository: IHouseRepository,
    private _fileUploadService: IFileUploadService,
    private _photoRepository: IPhotoRepository
  ) {}
  createHouse = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const houseDto = new HouseDTO(req.body);
      console.log(houseDto)
      const ValidationError = await validate(houseDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      console.log(req.body);

      const house = new House(houseDto);
      // Upload photos
      if (req.files) {
        //TODO: Add more validations and remove unnecessary files during errors
        const houseImages = req.files as Express.Multer.File[];
        const uploadedImages = houseImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              house.photos.push(photo.id);
            });
          });
        }
      }

      const createdHouse = await this.houseRepository.Create(house);
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(createdHouse));
    }
  );
  getHouseById = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const houseId = req.params.id;

      const house = await this.houseRepository.GetById(Object(houseId));
      if (!house) {
        throw new BadRequestError("House not found");
      }
      res.status(StatusCodes.OK).json(new JSendResponse().success(house));
    }
  );

  getAllHouse = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      
      const houses = await this.houseRepository.GetAll();
      res.status(StatusCodes.OK).json(new JSendResponse().success(houses));
    }
  );

  getHouseByFilter = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const filter = req.body;
      const houses = await this.houseRepository.GetByFilter(filter);
      res.status(StatusCodes.OK).json(new JSendResponse().success(houses));
    }
  );

  deleteHouse = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const houseId = req.params.id;
      const house = await this.houseRepository.GetById(Object(houseId));
      if (!house) {
        throw new BadRequestError("House not found");
      }
      await this.houseRepository.Delete(house._id);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  updateHouse = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const houseId = req.params.id;
      const houseDto = new HouseDTO(req.body);
      const ValidationError = await validate(houseDto);
      if (ValidationError.length > 0) {
        throw CustomValidationError.Instance(ValidationError);
      }
      const oldHouse = await this.houseRepository.GetById(Object(houseId));
      if (!oldHouse) {
        throw new BadRequestError("House not found");
      }

      const house = new House(houseDto);

      const updatedHouse = await this.houseRepository.Update(
        Object(houseId),
        house
      );
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(updatedHouse));
    }
  );

  deleteHousePhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const houseId = req.params.id;
      const photoId = req.params.photoId;
      const house = await this.houseRepository.GetById(Object(houseId));
      if (!house) {
        throw new BadRequestError("House not found");
      }
      const photo = await this._photoRepository.GetById(Object(photoId));
      if (!photo) {
        throw new BadRequestError("Photo not found");
      }
      house.photos = house.photos.filter((photo) => photo !== Object(photoId));
      await this.houseRepository.Update(Object(houseId), house);
      await this._photoRepository.Delete(Object(photoId));
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  addHousePhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const houseId = req.params.id;
      const house = await this.houseRepository.GetById(Object(houseId));
      if (!house) {
        throw new BadRequestError("House not found");
      }
      if (req.files) {
        const houseImages = req.files as Express.Multer.File[];
        const uploadedImages = houseImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              house.photos.push(photo.id);
            });
          });
        }
      }
      await this.houseRepository.Update(Object(houseId), house);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  getHousePhotos = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const houseId = req.params.id;
      const house = await this.houseRepository.GetById(Object(houseId));
      if (!house) {
        throw new BadRequestError("House not found");
      }
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(house.photos));
    }
  );
}
