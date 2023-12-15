import { Router } from "express";
import upload from "config/multer.config";
import { FileUploadService } from "infrastructure/service/FileUploadService";
import { RealState, RealStateEntity } from "@entities/RealStateEntity";
import { PhotoRepository } from "@repositories/PhotoRepository";
import { Photo } from "@entities/PhotoEntity";
import { advancedResults } from "webapi/middlewares/aggregate.filter.middleware";
import { Model } from "mongoose";
import { FavoriteController } from "webapi/controllers/favorite.controller";
import { RealStateRepository } from "@repositories/RealStateRepository";
import { FavoriteRepository } from "@repositories/FavoriteRepository";
import { Favorite } from "@entities/FavoriteEntity";
import { Vehicle } from "@entities/VehicleEntity";
import { VehicleRepository } from "@repositories/VehicleRepository";

const favoriteRoute = Router();
const realStateRepository = new RealStateRepository(RealState);
const photoRepository = new PhotoRepository(Photo);
const favoriteRepository = new FavoriteRepository(Favorite);
const vehicleRepository = new VehicleRepository(Vehicle);

const favoriteController = new FavoriteController(
  favoriteRepository,
  realStateRepository,
  photoRepository,
  vehicleRepository
);

// Routes for favoriteController
favoriteRoute.post("/", favoriteController.addToFavorite);
favoriteRoute.delete("/:id", favoriteController.removeFromFavorite);
favoriteRoute.get("/", favoriteController.getMyFavorite);

export { favoriteRoute };
