import { Router } from "express";
import { HouseController } from "webapi/controllers/house.controller";
import upload from "config/multer.config";
import { FileUploadService } from "infrastructure/service/FileUploadService";
import { HouseRepository } from "@repositories/HouseRepository";
import { House } from "@entities/HouseEntity";
import { PhotoRepository } from "@repositories/PhotoRepository";
import { Photo } from "@entities/PhotoEntity";

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
houseRoute.post("/filter", houseController.getHouseByFilter);
houseRoute.get("/all", houseController.getAllHouse);
houseRoute.get("/:id", houseController.getHouseById);
houseRoute.delete("/:id", houseController.deleteHouse);
houseRoute.put("/:id", houseController.updateHouse);
houseRoute.delete("/:id/photo/:photoId", houseController.deleteHousePhoto);
houseRoute.post("/:id/photo", upload.array("photos", 5), houseController.addHousePhoto);
houseRoute.get("/:id/photos", houseController.getHousePhotos);

export { houseRoute };
