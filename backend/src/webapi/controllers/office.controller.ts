import { OfficeDTO } from "@dtos/OfficeDTO";
import { OfficeResponseDTO } from "@dtos/OfficeResponseDTO";
import { LocationDTO } from "@dtos/LocationDTO";
import { LocationResponseDTO } from "@dtos/LocationResponseDTO";
import { PhotoResponseDTO } from "@dtos/photoResponseDTO";
import { uploadedFileDTO } from "@dtos/uploadedFileDTO";
import { HallEntity } from "@entities/HallEntity";
import { Office, OfficeEntity } from "@entities/OfficeEntity";
import { LandEntity } from "@entities/LandEntity";
import { Photo } from "@entities/PhotoEntity";
import { BadRequestError } from "@error-custom/BadRequestError";
import { JSendResponse } from "@error-custom/JsendResponse";
import { CustomValidationError } from "@error-custom/ValidationError";
import { IHallRepository } from "@interfaces/repositories/IHallRepository";
import { IOfficeRepository } from "@interfaces/repositories/IOfficeRepository";
import { ILandRepository } from "@interfaces/repositories/ILandRepository";
import { IPhotoRepository } from "@interfaces/repositories/IPhotoRepository";
import { IFileUploadService } from "@interfaces/services/IFileService";
import { validate } from "class-validator";
import { NextFunction, Request, Response } from "express";
import { StatusCodes } from "http-status-codes";
import { asyncHandler } from "webapi/middlewares/async.handler.middleware";

export class OfficeController {
  constructor(
    private officeRepository: IOfficeRepository,
    private _fileUploadService: IFileUploadService,
    private _photoRepository: IPhotoRepository
  ) {}
  createoffice = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      console.log(req.body);
      const officeDto = new OfficeDTO(req.body);

      console.log(officeDto);
      const ValidationError = await validate(officeDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      console.log(req.body);

      const office = new Office(officeDto);
      // Upload photos
      if (req.files) {
        //TODO: Add more validations and remove unnecessary files during errors
        const officeImages = req.files as Express.Multer.File[];
        const uploadedImages = officeImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              office.photos.push(photo.id);
            });
          });
        }
      }

      const createdoffice = await this.officeRepository.CreateOffice(office);
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(createdoffice));
    }
  );
  getofficeById = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const officeId = req.params.id;

      const office = await this.officeRepository.GetById(Object(officeId));

      
      if (!office) {
        throw new BadRequestError("office not found");
      }
      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of office.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(curPhoto);
        });
      }
      const resultoffice = new OfficeResponseDTO(
        office._id,
        office.title,
        office.minPrice,
        office.maxPrice,
        office.category,
        office.rooms,
        office.size,
        office.sizeUnit,
        new LocationResponseDTO(
          office.location.region,
          office.location.district,
          office.location.ward
        ),
        uploadedImages,
        office.otherFeatures,
        office.description,
        office.isApproved
      );
      res.status(StatusCodes.OK).json(new JSendResponse().success(resultoffice));
    }
  );

  getAllOffice = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(req.advancedResults));
    }
  );

  getOfficeByFilter = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const filter = req.body;
      const offices = await this.officeRepository.GetByFilter(filter);
      res.status(StatusCodes.OK).json(new JSendResponse().success(offices));
    }
  );

  deleteOffice = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const officeId = req.params.id;
      const office = await this.officeRepository.GetById(Object(officeId));
      if (!office) {
        throw new BadRequestError("office not found");
      }
      await this.officeRepository.Delete(office._id);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  updateOffice = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const officeId = req.params.id;
      const officeDto = new OfficeDTO(req.body);
      const ValidationError = await validate(officeDto);
      if (ValidationError.length > 0) {
        console.log("validation error", ValidationError.length);
        throw CustomValidationError.Instance(ValidationError);
      }
      const oldoffice = await this.officeRepository.GetById(Object(officeId));
      if (!oldoffice) {
        throw new BadRequestError("office not found");
      }


      const office = new Office(officeDto);
      office.id = oldoffice._id;
      office.photos = oldoffice.photos;
      console.log(office);

      const updatedoffice = await this.officeRepository.Update(
        Object(officeId),
        office
      );

      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of office.photos) {
        await this._photoRepository.GetById(e).then((curPhoto) => {
          uploadedImages.push(curPhoto);
        });
      }
      const resultoffice = new OfficeResponseDTO(
        updatedoffice._id,
        updatedoffice.title,
        updatedoffice.minPrice,
        updatedoffice.maxPrice,
        updatedoffice.category,
        updatedoffice.rooms,
        updatedoffice.size,
        updatedoffice.sizeUnit,
        new LocationResponseDTO(
          updatedoffice.location.region,
          updatedoffice.location.district,
          updatedoffice.location.ward
        ),
        uploadedImages,
        updatedoffice.otherFeatures,
        updatedoffice.description,
        updatedoffice.isApproved
      );


      res
        .status(StatusCodes.OK)
        .json(new JSendResponse().success(resultoffice));
    }
  );

  deleteOfficePhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const officeId = req.params.id;
      const photoId = req.params.photoId;
      const office = await this.officeRepository.GetById(Object(officeId));
      if (!office) {
        throw new BadRequestError("office not found");
      }
      const photo = await this._photoRepository.GetById(Object(photoId));
      if (!photo) {
        throw new BadRequestError("Photo not found");
      }
      office.photos = office.photos.filter((photo) => {
        console.log("photo start");
        console.log(photo._id.valueOf());
        console.log(Object(photoId));
        console.log("photo end");
        return photo._id.valueOf() !== photoId.valueOf();
      });

      console.log(office.photos);
      await this.officeRepository.Update(Object(officeId), office);
      await this._photoRepository.Delete(Object(photoId));
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  addOfficePhoto = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const officeId = req.params.id;
      const office = await this.officeRepository.GetById(Object(officeId));
      if (!office) {
        throw new BadRequestError("office not found");
      }
      if (req.files) {
        const officeImages = req.files as Express.Multer.File[];
        const uploadedImages = officeImages.map(async (image, _) => {
          return await this._fileUploadService.uploadFile(image);
        });

        await Promise.all(uploadedImages);

        for (let uploadedImage of uploadedImages) {
          await uploadedImage.then(async (image) => {
            const photo = new Photo(image);
            await this._photoRepository.Create(photo).then((_) => {
              office.photos.push(photo.id);
            });
          });
        }
      }
      await this.officeRepository.Update(Object(officeId), office);
      res.status(StatusCodes.OK).json(new JSendResponse().success({}));
    }
  );

  getOfficePhotos = asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      const officeId = req.params.id;
      const office = await this.officeRepository.GetById(Object(officeId));
      if (!office) {
        throw new BadRequestError("office not found");
      }
      
      const uploadedImages: PhotoResponseDTO[] = [];
      for (let e of office.photos) {
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
