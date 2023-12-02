import { Router } from "express";
import { HouseController } from "webapi/controllers/house.controller";
import upload from "config/multer.config";
import { FileUploadService } from "infrastructure/service/FileUploadService";
import { HouseRepository } from "@repositories/HouseRepository";
import { House, HouseEntity } from "@entities/HouseEntity";
import { PhotoRepository } from "@repositories/PhotoRepository";
import { Photo } from "@entities/PhotoEntity";
import { advancedResults } from "webapi/middlewares/aggregate.filter.middleware";
import { Model } from "mongoose";

const houseRoute = Router();
const fileUploadService = new FileUploadService();
const houseRepository = new HouseRepository(House);
const photoRepository = new PhotoRepository(Photo);


const houseController = new HouseController(
    houseRepository,
    fileUploadService,
    photoRepository
);

// Routes for HouseController
houseRoute.post("/", upload.array("photos", 5), houseController.createHouse);
// houseRoute.post("/filter", advancedResults<HouseEntity>(House, ""), houseController.getAllHouse);
houseRoute.get("/all", advancedResults<HouseEntity>(House, "photos"), houseController.getAllHouse);
houseRoute.get("/:id", houseController.getHouseById);
houseRoute.delete("/:id", houseController.deleteHouse);
houseRoute.put("/:id", upload.array("photos", 5), houseController.updateHouse);
houseRoute.delete("/:id/photos/:photoId", houseController.deleteHousePhoto);
houseRoute.post("/:id/photos", upload.array("photos", 5), houseController.addHousePhoto);
houseRoute.get("/:id/photos", houseController.getHousePhotos);

export { houseRoute };
