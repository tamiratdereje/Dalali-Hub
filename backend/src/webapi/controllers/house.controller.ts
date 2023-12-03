import { HouseDTO } from "@dtos/HouseDTO";
import { HouseResponseDTO } from "@dtos/HouseResponseDTO";
import { LocationDTO } from "@dtos/LocationDTO";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";
import { uploadedFileDTO } from "@dtos/uploadedFileDTO";
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
      console.log(req.body);
      const houseDto = new HouseDTO(JSON.parse(req.body.house));

      console.log(houseDto);
      const ValidationError = await validate(houseDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      console.log(houseDto);

      const house = new House(houseDto);
      console.log("files")
      console.log(req.files)
      console.log("files")
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

      const createdHouse = await this.houseRepository.CreateHouse(house);
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
      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of house.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(curPhoto);
        });
      }
      const resultHouse = new HouseResponseDTO(
        house._id,
        house.title,
        house.minPrice,
        house.maxPrice,
        house.category,
        house.rooms,
        house.beds,
        house.baths,
        house.kitchens,
        house.size,
        house.sizeUnit,
        new LocationResponseDTO(
          house.location.region,
          house.location.district,
          house.location.ward
        ),
        uploadedImages,
        house.otherFeatures,
        house.description,
        house.isApproved
      );
      res.status(StatusCodes.OK).json(new JSendResponse().success(resultHouse));
    }
  );

  getAllHouse = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(req.advancedResults));
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
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      const oldHouse = await this.houseRepository.GetById(Object(houseId));
      if (!oldHouse) {
        throw new BadRequestError("House not found");
      }


      const house = new House(houseDto);
      house.id = oldHouse._id;
      house.photos = oldHouse.photos;
      console.log(house);

      const updatedHouse = await this.houseRepository.Update(
        Object(houseId),
        house
      );

      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of house.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(curPhoto);
        });
      }
      const resultHouse = new HouseResponseDTO(
        updatedHouse._id,
        updatedHouse.title,
        updatedHouse.minPrice,
        updatedHouse.maxPrice,
        updatedHouse.category,
        updatedHouse.rooms,
        updatedHouse.beds,
        updatedHouse.baths,
        updatedHouse.kitchens,
        updatedHouse.size,
        updatedHouse.sizeUnit,
        new LocationResponseDTO(
          updatedHouse.location.region,
          updatedHouse.location.district,
          updatedHouse.location.ward
        ),
        uploadedImages,
        updatedHouse.otherFeatures,
        updatedHouse.description,
        updatedHouse.isApproved
      );


      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(resultHouse));
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
      house.photos = house.photos.filter((photo) => {
        console.log("photo start");
        console.log(photo._id.valueOf());
        console.log(Object(photoId));
        console.log("photo end");
        return photo._id.valueOf() !== photoId.valueOf();
      });

      console.log(house.photos);
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
      
      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of house.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(curPhoto);
        });
      }
      
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(uploadedImages));
    }
  );
}
