import { RealStateDTO } from "@dtos/RealStateDTO";
import { RealStateResponseDTO } from "@dtos/RealStateResponseDTO";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";

import { Photo } from "@entities/PhotoEntity";
import { BadRequestError } from "@error-custom/BadRequestError";
import { JSendResponse } from "@error-custom/JsendResponse";
import { CustomValidationError } from "@error-custom/ValidationError";
import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { IFileUploadService } from "@interfaces/services/IFileService";
import { validate } from "class-validator";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";
import { IRealStateRepository } from "@interfaces/repositories/IRealStateRepository";
import { RealState } from "@entities/RealStateEntity";

export class RealStateController {
  constructor(
    private realStateRepository: IRealStateRepository,
    private _fileUploadService: IFileUploadService,
    private _photoRepository: IPhotoRepository
  ) {}
  createRealState = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log(req.body);
      const realStateDto = new RealStateDTO(JSON.parse(req.body.realState));

      console.log(realStateDto);
      const ValidationError = await validate(realStateDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      console.log(realStateDto);

      const realState = new RealState(realStateDto);
      console.log("files")
      console.log(req.files)
      console.log("files")
      // Upload photos
      if (req.files) {
        //TODO: Add more validations and remove unnecessary files during errors
        const realStateImages = req.files as Express.Multer.File[];
        const uploadedImages = realStateImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              realState.photos.push(photo.id);
            });
          });
        }
      }

      const createdRealState = await this.realStateRepository.CreateRealState(realState);
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(createdRealState));
    }
  );
  getRealStateById = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const realStateId = req.params.id;

      const realState = await this.realStateRepository.GetById(Object(realStateId));

      
      if (!realState) {
        throw new BadRequestError("realState not found");
      }
      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of realState.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(new PhotoResponseDTO(curPhoto.publicId, curPhoto.secureUrl, curPhoto._id));
        });
      }
      const resultRealState = new RealStateResponseDTO(
        realState._id,
        realState.title,
        realState.minPrice,
        realState.maxPrice,
        realState.category,
        realState.seats,
        realState.size,
        realState.sizeUnit,
        new LocationResponseDTO(
          realState.location.region,
          realState.location.district,
          realState.location.ward
        ),
        uploadedImages,
        realState.otherFeatures,
        realState.description,
        realState.isApproved,
        realState.rooms,
        realState.beds,
        realState.baths,
        realState.kitchens,        
      );
      res.status(StatusCodes.OK).json(new JSendResponse().success(resultRealState));
    }
  );

  getAllRealState = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(req.advancedResults));
    }
  );

  getRealStateByFilter = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const filter = req.body;
      const realStates = await this.realStateRepository.GetByFilter(filter);
      res.status(StatusCodes.OK).json(new JSendResponse().success(realStates));
    }
  );

  deleteRealState = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const realStateId = req.params.id;
      const realState = await this.realStateRepository.GetById(Object(realStateId));
      if (!realState) {
        throw new BadRequestError("RealState not found");
      }
      await this.realStateRepository.Delete(realState._id);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  updateRealState = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const realStateId = req.params.id;
      const realStateDto = new RealStateDTO(req.body);
      const ValidationError = await validate(realStateDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      const oldRealState = await this.realStateRepository.GetById(Object(realStateId));
      if (!oldRealState) {
        throw new BadRequestError("RealState not found");
      }


      const realState = new RealState(realStateDto);
      realState.id = oldRealState._id;
      realState.photos = oldRealState.photos;
      console.log(realState);

      const updatedRealState = await this.realStateRepository.Update(
        Object(realStateId),
        realState
      );

      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of realState.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(new PhotoResponseDTO(curPhoto.publicId, curPhoto.secureUrl, curPhoto._id));
        });
      }
      const resultRealState = new RealStateResponseDTO(
        updatedRealState._id,
        updatedRealState.title,
        updatedRealState.minPrice,
        updatedRealState.maxPrice,
        updatedRealState.category,
        updatedRealState.seats,
        updatedRealState.size,
        updatedRealState.sizeUnit,
        new LocationResponseDTO(
          updatedRealState.location.region,
          updatedRealState.location.district,
          updatedRealState.location.ward
        ),
        uploadedImages,
        updatedRealState.otherFeatures,
        updatedRealState.description,
        updatedRealState.isApproved,
        updatedRealState.rooms,
        updatedRealState.beds,
        updatedRealState.baths,
        updatedRealState.kitchens,   
      );


      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(resultRealState));
    }
  );

  deleteRealStatePhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const realStateId = req.params.id;
      const photoId = req.params.photoId;
      const realState = await this.realStateRepository.GetById(Object(realStateId));
      if (!realState) {
        throw new BadRequestError("RealState not found");
      }
      const photo = await this._photoRepository.GetById(Object(photoId));
      if (!photo) {
        throw new BadRequestError("Photo not found");
      }
      realState.photos = realState.photos.filter((photo) => {
        console.log("photo start");
        console.log(photo._id.valueOf());
        console.log(Object(photoId));
        console.log("photo end");
        return photo._id.valueOf() !== photoId.valueOf();
      });

      console.log(realState.photos);
      await this.realStateRepository.Update(Object(realStateId), realState);
      await this._photoRepository.Delete(Object(photoId));
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  addRealStatePhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const realStateId = req.params.id;
      const realState = await this.realStateRepository.GetById(Object(realStateId));
      if (!realState) {
        throw new BadRequestError("RealState not found");
      }
      if (req.files) {
        const realStateImages = req.files as Express.Multer.File[];
        const uploadedImages = realStateImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              realState.photos.push(photo.id);
            });
          });
        }
      }
      await this.realStateRepository.Update(Object(realStateId), realState);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  getRealStatePhotos = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const realStateId = req.params.id;
      const realState = await this.realStateRepository.GetById(Object(realStateId));
      if (!realState) {
        throw new BadRequestError("RealState not found");
      }
      
      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of realState.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(new PhotoResponseDTO(curPhoto.publicId, curPhoto.secureUrl, curPhoto._id));
        });
      }
      
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(uploadedImages));
    }
  );
}
