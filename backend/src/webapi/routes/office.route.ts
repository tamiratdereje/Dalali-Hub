import { Router } from "express";
import upload from "config/multer.config";
import { FileUploadService } from "infrastructure/service/FileUploadService";
import { OfficeRepository } from "@repositories/OfficeRepository";
import { Office, OfficeEntity } from "@entities/OfficeEntity";
import { PhotoRepository } from "@repositories/PhotoRepository";
import { Photo } from "@entities/PhotoEntity";
import { advancedResults } from "webapi/middlewares/aggregate.filter.middleware";
import { Model } from "mongoose";
import { OfficeController } from "webapi/controllers/office.controller";

const officeRoute = Router();
const fileUploadService = new FileUploadService();
const officeRepository = new OfficeRepository(Office);
const photoRepository = new PhotoRepository(Photo);


const officeController = new OfficeController(
    officeRepository,
    fileUploadService,
    photoRepository
);

// Routes for officeController
officeRoute.post("/", upload.array("photos", 5), officeController.createoffice);
// officeRoute.post("/filter", advancedResults<officeEntity>(office, ""), officeController.getAlloffice);
officeRoute.get("/all", advancedResults<OfficeEntity>(Office, "photos"), officeController.getAllOffice);
officeRoute.get("/:id", officeController.getofficeById);
officeRoute.delete("/:id", officeController.deleteOffice);
officeRoute.put("/:id", upload.array("photos", 5), officeController.updateOffice);
officeRoute.delete("/:id/photos/:photoId", officeController.deleteOfficePhoto);
officeRoute.post("/:id/photos", upload.array("photos", 5), officeController.addOfficePhoto);
officeRoute.get("/:id/photos", officeController.getOfficePhotos);

export { officeRoute };
