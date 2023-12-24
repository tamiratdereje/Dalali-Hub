import { Favorite } from "@entities/FavoriteEntity";
import { Photo } from "@entities/PhotoEntity";
import { RealState } from "@entities/RealStateEntity";
import { User } from "@entities/UserEntity";
import { Vehicle } from "@entities/VehicleEntity";
import { FavoriteRepository } from "@repositories/FavoriteRepository";

import { PhotoRepository } from "@repositories/PhotoRepository";
import { RealStateRepository } from "@repositories/RealStateRepository";
import { UserRepository } from "@repositories/UserRepository";
import { VehicleRepository } from "@repositories/VehicleRepository";
import { Router } from "express";
import { FeedController } from "webapi/controllers/feed.controller";
import { protectRoute } from "webapi/middlewares/auth.handler.middleware";

const photoRepository = new PhotoRepository(Photo);
const realstateRepository = new RealStateRepository(RealState);
const vehicleRepository = new VehicleRepository(Vehicle);
const userRepository = new UserRepository(User);
const favoriteRepository = new FavoriteRepository(Favorite);

const feedRoute = Router();
const feedController = new FeedController(
  realstateRepository,
  vehicleRepository,
  photoRepository,
  userRepository,
  favoriteRepository
);

feedRoute.get("/", protectRoute, feedController.getAllFeeds);
feedRoute.get("/:id", protectRoute, feedController.getProperty);

export { feedRoute };
