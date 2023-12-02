import { HallDTO } from "@dtos/HallDTO";
import { HallResponseDTO } from "@dtos/HallResponseDTO";
import { LocationDTO } from "@dtos/LocationDTO";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";
import { uploadedFileDTO } from "@dtos/uploadedFileDTO";
import { Hall, HallEntity } from "@entities/HallEntity";
import { LandEntity } from "@entities/LandEntity";
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

export class HallController {
  constructor(
    private hallRepository: IHallRepository,
    private _fileUploadService: IFileUploadService,
    private _photoRepository: IPhotoRepository
  ) {}
  createHall = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log(req.body);
      const hallDto = new HallDTO(req.body);

      console.log(hallDto);
      const ValidationError = await validate(hallDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      console.log(req.body);

      const hall = new Hall(hallDto);
      // Upload photos
      if (req.files) {
        //TODO: Add more validations and remove unnecessary files during errors
        const hallImages = req.files as Express.Multer.File[];
        const uploadedImages = hallImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              hall.photos.push(photo.id);
            });
          });
        }
      }

      const createdhall = await this.hallRepository.CreateHall(hall);
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(createdhall));
    }
  );
  getHallById = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const hallId = req.params.id;

      const hall = await this.hallRepository.GetById(Object(hallId));

      
      if (!hall) {
        throw new BadRequestError("hall not found");
      }
      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of hall.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(curPhoto);
        });
      }
      const resultHall = new HallResponseDTO(
        hall._id,
        hall.title,
        hall.minPrice,
        hall.maxPrice,
        hall.category,
        hall.seats,
        hall.size,
        hall.sizeUnit,
        new LocationResponseDTO(
          hall.location.region,
          hall.location.district,
          hall.location.ward
        ),
        uploadedImages,
        hall.otherFeatures,
        hall.description,
        hall.isApproved,
        
      );
      res.status(StatusCodes.OK).json(new JSendResponse().success(resultHall));
    }
  );

  getAllHall = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(req.advancedResults));
    }
  );

  getHallByFilter = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const filter = req.body;
      const halls = await this.hallRepository.GetByFilter(filter);
      res.status(StatusCodes.OK).json(new JSendResponse().success(halls));
    }
  );

  deleteHall = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const hallId = req.params.id;
      const hall = await this.hallRepository.GetById(Object(hallId));
      if (!hall) {
        throw new BadRequestError("hall not found");
      }
      await this.hallRepository.Delete(hall._id);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  updateHall = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const hallId = req.params.id;
      const hallDto = new HallDTO(req.body);
      const ValidationError = await validate(hallDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      const oldhall = await this.hallRepository.GetById(Object(hallId));
      if (!oldhall) {
        throw new BadRequestError("hall not found");
      }


      const hall = new Hall(hallDto);
      hall.id = oldhall._id;
      hall.photos = oldhall.photos;
      console.log(hall);

      const updatedhall = await this.hallRepository.Update(
        Object(hallId),
        hall
      );

      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of hall.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(curPhoto);
        });
      }
      const resulthall = new HallResponseDTO(
        updatedhall._id,
        updatedhall.title,
        updatedhall.minPrice,
        updatedhall.maxPrice,
        updatedhall.category,
        updatedhall.seats,
        updatedhall.size,
        updatedhall.sizeUnit,
        new LocationResponseDTO(
          updatedhall.location.region,
          updatedhall.location.district,
          updatedhall.location.ward
        ),
        uploadedImages,
        updatedhall.otherFeatures,
        updatedhall.description,
        updatedhall.isApproved
      );


      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(resulthall));
    }
  );

  deleteHallPhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const hallId = req.params.id;
      const photoId = req.params.photoId;
      const hall = await this.hallRepository.GetById(Object(hallId));
      if (!hall) {
        throw new BadRequestError("hall not found");
      }
      const photo = await this._photoRepository.GetById(Object(photoId));
      if (!photo) {
        throw new BadRequestError("Photo not found");
      }
      hall.photos = hall.photos.filter((photo) => {
        console.log("photo start");
        console.log(photo._id.valueOf());
        console.log(Object(photoId));
        console.log("photo end");
        return photo._id.valueOf() !== photoId.valueOf();
      });

      console.log(hall.photos);
      await this.hallRepository.Update(Object(hallId), hall);
      await this._photoRepository.Delete(Object(photoId));
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  addHallPhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const hallId = req.params.id;
      const hall = await this.hallRepository.GetById(Object(hallId));
      if (!hall) {
        throw new BadRequestError("hall not found");
      }
      if (req.files) {
        const hallImages = req.files as Express.Multer.File[];
        const uploadedImages = hallImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              hall.photos.push(photo.id);
            });
          });
        }
      }
      await this.hallRepository.Update(Object(hallId), hall);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  getHallPhotos = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const hallId = req.params.id;
      const hall = await this.hallRepository.GetById(Object(hallId));
      if (!hall) {
        throw new BadRequestError("hall not found");
      }
      
      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of hall.photos) {
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
