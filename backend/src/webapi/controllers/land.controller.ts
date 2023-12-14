import { LandDTO } from "@dtos/LandDTO";
import { LandResponseDTO } from "@dtos/LandResponseDTO";
import { LocationDTO } from "@dtos/LocationDTO";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";
import { uploadedFileDTO } from "@dtos/uploadedFileDTO";
import { HallEntity } from "@entities/HallEntity";
import { Land, LandEntity } from "@entities/LandEntity";
import { OfficeEntity } from "@entities/OfficeEntity";
import { Photo } from "@entities/PhotoEntity";
import { BadRequestError } from "@error-custom/BadRequestError";
import { JSendResponse } from "@error-custom/JsendResponse";
import { CustomValidationError } from "@error-custom/ValidationError";
import { IHallRepository } from "@interfaces/repositories/IHallRepository";
import { ILandRepository } from "@interfaces/repositories/ILandRepository";
import { IOfficeRepository } from "@interfaces/repositories/IOfficeRepository";
import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { IFileUploadService } from "@interfaces/services/IFileService";
import { validate } from "class-validator";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";

export class LandController {
  constructor(
    private landRepository: ILandRepository,
    private _fileUploadService: IFileUploadService,
    private _photoRepository: IPhotoRepository
  ) {}
  createLand = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log(req.body);
      const landDto = new LandDTO(req.body);

      console.log(landDto);
      const ValidationError = await validate(landDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      console.log(req.body);

      const land = new Land(landDto);
      // Upload photos
      if (req.files) {
        //TODO: Add more validations and remove unnecessary files during errors
        const landImages = req.files as Express.Multer.File[];
        const uploadedImages = landImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              land.photos.push(photo.id);
            });
          });
        }
      }

      const createdland = await this.landRepository.CreateLand(land);
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(createdland));
    }
  );
  getLandById = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const landId = req.params.id;

      const land = await this.landRepository.GetById(Object(landId));

      
      if (!land) {
        throw new BadRequestError("land not found");
      }
      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of land.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(curPhoto);
        });
      }
      const resultland = new LandResponseDTO(
        land._id,
        land.title,
        land.minPrice,
        land.maxPrice,
        land.category,
        land.size,
        land.sizeUnit,
        new LocationResponseDTO(
          land.location.region,
          land.location.district,
          land.location.ward
        ),
        uploadedImages,
        land.otherFeatures,
        land.description,
        land.isApproved
      );
      res.status(StatusCodes.OK).json(new JSendResponse().success(resultland));
    }
  );

  getAllLand = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const lands = await this.landRepository.Query(req.queryString, req.populate, req.page, req.limit);
      const paginatedResult = new JSendResponse().successPaginated(
        lands,
        req.page + 1, 
        lands.length);
        
      res
        .status(StatusCodes.OK)
        .json(paginatedResult);
    }
  );

  getLandByFilter = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const filter = req.body;
      const lands = await this.landRepository.GetByFilter(filter);
      res.status(StatusCodes.OK).json(new JSendResponse().success(lands));
    }
  );

  deleteLand = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const landId = req.params.id;
      const land = await this.landRepository.GetById(Object(landId));
      if (!land) {
        throw new BadRequestError("land not found");
      }
      await this.landRepository.Delete(land._id);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  updateLand = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const landId = req.params.id;
      const landDto = new LandDTO(req.body);
      const ValidationError = await validate(landDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      const oldland = await this.landRepository.GetById(Object(landId));
      if (!oldland) {
        throw new BadRequestError("land not found");
      }


      const land = new Land(landDto);
      land.id = oldland._id;
      land.photos = oldland.photos;
      console.log(land);

      const updatedland = await this.landRepository.Update(
        Object(landId),
        land
      );

      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of land.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(curPhoto);
        });
      }
      const resultLand = new LandResponseDTO(
        updatedland._id,
        updatedland.title,
        updatedland.minPrice,
        updatedland.maxPrice,
        updatedland.category,
        updatedland.size,
        updatedland.sizeUnit,
        new LocationResponseDTO(
          updatedland.location.region,
          updatedland.location.district,
          updatedland.location.ward
        ),
        uploadedImages,
        updatedland.otherFeatures,
        updatedland.description,
        updatedland.isApproved
      );


      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(resultLand));
    }
  );

  deleteLandPhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const landId = req.params.id;
      const photoId = req.params.photoId;
      const land = await this.landRepository.GetById(Object(landId));
      if (!land) {
        throw new BadRequestError("land not found");
      }
      const photo = await this._photoRepository.GetById(Object(photoId));
      if (!photo) {
        throw new BadRequestError("Photo not found");
      }
      land.photos = land.photos.filter((photo) => {
        console.log("photo start");
        console.log(photo._id.valueOf());
        console.log(Object(photoId));
        console.log("photo end");
        return photo._id.valueOf() !== photoId.valueOf();
      });

      console.log(land.photos);
      await this.landRepository.Update(Object(landId), land);
      await this._photoRepository.Delete(Object(photoId));
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  addLandPhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const landId = req.params.id;
      const land = await this.landRepository.GetById(Object(landId));
      if (!land) {
        throw new BadRequestError("Land not found");
      }
      if (req.files) {
        const landImages = req.files as Express.Multer.File[];
        const uploadedImages = landImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              land.photos.push(photo.id);
            });
          });
        }
      }
      await this.landRepository.Update(Object(landId), land);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  getLandPhotos = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const landId = req.params.id;
      const land = await this.landRepository.GetById(Object(landId));
      if (!land) {
        throw new BadRequestError("land not found");
      }
      
      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of land.photos) {
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
