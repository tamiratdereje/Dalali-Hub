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
import { UserRepository } from "@repositories/UserRepository";
import { User } from "@entities/UserEntity";
import { protectRoute } from "webapi/middlewares/auth.handler.middleware";
import { FavoriteRepository } from "@repositories/FavoriteRepository";
import { Favorite } from "@entities/FavoriteEntity";

const vehicleRoute = Router();
const fileUploadService = new FileUploadService();
const vehicleRepository = new VehicleRepository(Vehicle);
const photoRepository = new PhotoRepository(Photo);
const userRepository = new UserRepository(User);
const favoriteRepository = new FavoriteRepository(Favorite);

const vehicleController = new VehicleController(
  vehicleRepository,
  fileUploadService,
  photoRepository,
  userRepository,
  favoriteRepository
);

// Routes for vehicleController
vehicleRoute.post(
  "/",
  protectRoute,
  upload.array("photos", 5),
  vehicleController.createVehicle
);
// VRoute.post("/filter", advancedResults<VEntity>(V, ""), VController.getAllV);
vehicleRoute.get(
  "/all",
  protectRoute,
  advancedResults<VehicleEntity>(Vehicle, "photos"),
  vehicleController.getAllVehicle
);
vehicleRoute.get("/:id", protectRoute, vehicleController.getVehicleById);
vehicleRoute.delete("/:id", protectRoute, vehicleController.deleteVehicle);
vehicleRoute.put(
  "/:id",
  protectRoute,
  upload.array("photos", 5),
  vehicleController.updateVehicle
);
vehicleRoute.delete(
  "/:id/photos/:photoId",
  protectRoute,
  vehicleController.deleteVehiclePhoto
);
vehicleRoute.post(
  "/:id/photos",
  protectRoute,
  upload.array("photos", 5),
  vehicleController.addVehiclePhoto
);
vehicleRoute.get(
  "/:id/photos",
  protectRoute,
  vehicleController.getVehiclePhotos
);

export { vehicleRoute };
