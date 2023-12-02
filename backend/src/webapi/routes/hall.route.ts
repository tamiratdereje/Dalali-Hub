import { Router } from "express";
import { HallController } from "webapi/controllers/hall.controller";
import upload from "config/multer.config";
import { FileUploadService } from "infrastructure/service/FileUploadService";
import { HallRepository } from "@repositories/HallRepository";
import { Hall, HallEntity } from "@entities/HallEntity";
import { PhotoRepository } from "@repositories/PhotoRepository";
import { Photo } from "@entities/PhotoEntity";
import { advancedResults } from "webapi/middlewares/aggregate.filter.middleware";
import { Model } from "mongoose";

const hallRoute = Router();
const fileUploadService = new FileUploadService();
const hallRepository = new HallRepository(Hall);
const photoRepository = new PhotoRepository(Photo);


const hallController = new HallController(
    hallRepository,
    fileUploadService,
    photoRepository
);

// Routes for HallController
hallRoute.post("/", upload.array("photos", 5), hallController.createHall);
// hallRoute.post("/filter", advancedResults<HallEntity>(Hall, ""), HallController.getAllHall);
hallRoute.get("/all", advancedResults<HallEntity>(Hall, "photos"), hallController.getAllHall);
hallRoute.get("/:id", hallController.getHallById);
hallRoute.delete("/:id", hallController.deleteHall);
hallRoute.put("/:id", upload.array("photos", 5), hallController.updateHall);
hallRoute.delete("/:id/photos/:photoId", hallController.deleteHallPhoto);
hallRoute.post("/:id/photos", upload.array("photos", 5), hallController.addHallPhoto);
hallRoute.get("/:id/photos", hallController.getHallPhotos);

export { hallRoute };
