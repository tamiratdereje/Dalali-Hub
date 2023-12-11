import { Router } from "express";
import upload from "config/multer.config";
import { FileUploadService } from "infrastructure/service/FileUploadService";
import { RealState, RealStateEntity } from "@entities/RealStateEntity";
import { PhotoRepository } from "@repositories/PhotoRepository";
import { Photo } from "@entities/PhotoEntity";
import { advancedResults } from "webapi/middlewares/aggregate.filter.middleware";
import { Model } from "mongoose";
import { RealStateController } from "webapi/controllers/realstate.controller";
import { RealStateRepository } from "@repositories/RealStateRepository";

const realStateRoute = Router();
const fileUploadService = new FileUploadService();
const realStateRepository = new RealStateRepository(RealState);
const photoRepository = new PhotoRepository(Photo);


const realStateController = new RealStateController(
    realStateRepository,
    fileUploadService,
    photoRepository
);

// Routes for realStateController
realStateRoute.post("/", upload.array("photos", 5), realStateController.createRealState);
// realStateRoute.post("/filter", advancedResults<RealStateEntity>(RealState, ""), realStateController.getAllRealState);
realStateRoute.get("/all", advancedResults<RealStateEntity>(RealState, "photos"), realStateController.getAllRealState);
realStateRoute.get("/:id", realStateController.getRealStateById);
realStateRoute.delete("/:id", realStateController.deleteRealState);
realStateRoute.put("/:id", upload.array("photos", 5), realStateController.updateRealState);
realStateRoute.delete("/:id/photos/:photoId", realStateController.deleteRealStatePhoto);
realStateRoute.post("/:id/photos", upload.array("photos", 5), realStateController.addRealStatePhoto);
realStateRoute.get("/:id/photos", realStateController.getRealStatePhotos);

export { realStateRoute };
