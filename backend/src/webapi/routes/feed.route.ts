import { Favorite } from "@entities/FavoriteEntity";
import { Photo } from "@entities/PhotoEntity";
import { RealState, RealStateEntity } from "@entities/RealStateEntity";
import { User } from "@entities/UserEntity";
import { Vehicle } from "@entities/VehicleEntity";
import { View } from "@entities/ViewEntity";
import { FavoriteRepository } from "@repositories/FavoriteRepository";

import { PhotoRepository } from "@repositories/PhotoRepository";
import { RealStateRepository } from "@repositories/RealStateRepository";
import { UserRepository } from "@repositories/UserRepository";
import { VehicleRepository } from "@repositories/VehicleRepository";
import { ViewRepository } from "@repositories/ViewRepository";
import { Router } from "express";
import { FeedController } from "webapi/controllers/feed.controller";
import { advancedResults } from "webapi/middlewares/aggregate.filter.middleware";
import { protectRoute } from "webapi/middlewares/auth.handler.middleware";

const photoRepository = new PhotoRepository(Photo);
const realstateRepository = new RealStateRepository(RealState);
const vehicleRepository = new VehicleRepository(Vehicle);
const userRepository = new UserRepository(User);
const favoriteRepository = new FavoriteRepository(Favorite);
const viewRepository = new ViewRepository(View);

const feedRoute = Router();
const feedController = new FeedController(
  realstateRepository,
  vehicleRepository,
  photoRepository,
  userRepository,
  favoriteRepository,
  viewRepository
);

feedRoute.get(
  "/",
  protectRoute,
  advancedResults<RealStateEntity>(RealState, "photos"),
  feedController.getAllFeeds
);
feedRoute.get("/stat", protectRoute, feedController.getMyStatistics);
feedRoute.get("/mine", protectRoute, advancedResults<RealStateEntity>(RealState, "photos"), feedController.getAllMyListing);
feedRoute.get("/:id", protectRoute, feedController.getProperty);

export { feedRoute };
