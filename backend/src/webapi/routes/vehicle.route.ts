import { Router } from "express";
import { VehicleController } from "webapi/controllers/vehicle.controller";
import upload from "config/multer.config";
import { FileUploadService } from "infrastructure/service/FileUploadService";
import { VehicleRepository } from "@repositories/VehicleRepository";
import { Vehicle, VehicleEntity } from "@entities/VehicleEntity";
import { PhotoRepository } from "@repositories/PhotoRepository";
import { Photo } from "@entities/PhotoEntity";
import { advancedResults } from "webapi/middlewares/aggregate.filter.middleware";
import { Model } from "mongoose";

const vehicleRoute = Router();
const fileUploadService = new FileUploadService();
const vehicleRepository = new VehicleRepository(Vehicle);
const photoRepository = new PhotoRepository(Photo);


const vehicleController = new VehicleController(
    vehicleRepository,
    fileUploadService,
    photoRepository
);

// Routes for vehicleController
vehicleRoute.post("/", upload.array("photos", 5), vehicleController.createVehicle);
// VRoute.post("/filter", advancedResults<VEntity>(V, ""), VController.getAllV);
vehicleRoute.get("/all", advancedResults<VehicleEntity>(Vehicle, "photos"), vehicleController.getAllVehicle);
vehicleRoute.get("/:id", vehicleController.getVehicleById);
vehicleRoute.delete("/:id", vehicleController.deleteVehicle);
vehicleRoute.put("/:id", upload.array("photos", 5), vehicleController.updateVehicle);
vehicleRoute.delete("/:id/photos/:photoId", vehicleController.deleteVehiclePhoto);
vehicleRoute.post("/:id/photos", upload.array("photos", 5), vehicleController.addVehiclePhoto);
vehicleRoute.get("/:id/photos", vehicleController.getVehiclePhotos);

export { vehicleRoute };
