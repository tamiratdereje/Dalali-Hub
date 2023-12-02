import { Router } from "express";
import { LandController } from "webapi/controllers/land.controller";
import upload from "config/multer.config";
import { FileUploadService } from "infrastructure/service/FileUploadService";
import { LandRepository } from "@repositories/LandRepository";
import { Land, LandEntity } from "@entities/LandEntity";
import { PhotoRepository } from "@repositories/PhotoRepository";
import { Photo } from "@entities/PhotoEntity";
import { advancedResults } from "webapi/middlewares/aggregate.filter.middleware";
import { Model } from "mongoose";

const landRoute = Router();
const fileUploadService = new FileUploadService();
const landRepository = new LandRepository(Land);
const photoRepository = new PhotoRepository(Photo);


const landController = new LandController(
    landRepository,
    fileUploadService,
    photoRepository
);

// Routes for landController
landRoute.post("/", upload.array("photos", 5), landController.createLand);
// landRoute.post("/filter", advancedResults<landEntity>(land, ""), landController.getAllland);
landRoute.get("/all", advancedResults<LandEntity>(Land, "photos"), landController.getAllLand);
landRoute.get("/:id", landController.getLandById);
landRoute.delete("/:id", landController.deleteLand);
landRoute.put("/:id", upload.array("photos", 5), landController.updateLand);
landRoute.delete("/:id/photos/:photoId", landController.deleteLandPhoto);
landRoute.post("/:id/photos", upload.array("photos", 5), landController.addLandPhoto);
landRoute.get("/:id/photos", landController.getLandPhotos);

export { landRoute };
