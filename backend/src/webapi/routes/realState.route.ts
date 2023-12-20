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
import { UserRepository } from "@repositories/UserRepository";
import { User } from "@entities/UserEntity";
import { protectRoute } from "webapi/middlewares/auth.handler.middleware";
import { FavoriteRepository } from "@repositories/FavoriteRepository";
import { Favorite } from "@entities/FavoriteEntity";

const realStateRoute = Router();
const fileUploadService = new FileUploadService();
const realStateRepository = new RealStateRepository(RealState);
const photoRepository = new PhotoRepository(Photo);
const userRepository = new UserRepository(User);
const favoriteRepository = new FavoriteRepository(Favorite);

const realStateController = new RealStateController(
  realStateRepository,
  fileUploadService,
  photoRepository,
  userRepository,
  favoriteRepository
);

// Routes for realStateController
realStateRoute.post(
  "/",
  protectRoute,
  upload.array("photos", 5),
  realStateController.createRealState
);
// realStateRoute.post("/filter", advancedResults<RealStateEntity>(RealState, ""), realStateController.getAllRealState);
realStateRoute.get(
  "/all",
  protectRoute,
  advancedResults<RealStateEntity>(RealState, "photos"),
  realStateController.getAllRealState
);
realStateRoute.get("/:id", protectRoute, realStateController.getRealStateById);
realStateRoute.delete(
  "/:id",
  protectRoute,
  realStateController.deleteRealState
);
realStateRoute.put(
  "/:id",
  protectRoute,
  upload.array("photos", 5),
  realStateController.updateRealState
);
realStateRoute.delete(
  "/:id/photos/:photoId",
  protectRoute,
  realStateController.deleteRealStatePhoto
);
realStateRoute.post(
  "/:id/photos",
  protectRoute,
  upload.array("photos", 5),
  realStateController.addRealStatePhoto
);
realStateRoute.get(
  "/:id/photos",
  protectRoute,
  realStateController.getRealStatePhotos
);

export { realStateRoute };
