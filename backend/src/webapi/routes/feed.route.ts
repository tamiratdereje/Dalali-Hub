import { Hall } from "@entities/HallEntity";
import { House } from "@entities/HouseEntity";
import { Land } from "@entities/LandEntity";
import { Office } from "@entities/OfficeEntity";
import { Photo } from "@entities/PhotoEntity";
import { RealState } from "@entities/RealStateEntity";
import { Vehicle } from "@entities/VehicleEntity";

import { PhotoRepository } from "@repositories/PhotoRepository";
import { RealStateRepository } from "@repositories/RealStateRepository";
import { VehicleRepository } from "@repositories/VehicleRepository";
import { Router } from "express";
import { FeedController } from "webapi/controllers/feed.controller";

const photoRepository = new PhotoRepository(Photo);
const realstateRepository = new RealStateRepository(RealState);
const vehicleRepository = new VehicleRepository(Vehicle);

const feedRoute = Router();
const feedController = new FeedController(
  realstateRepository,
  vehicleRepository,
  photoRepository
);

feedRoute.get("/", feedController.getAllFeeds);

export { feedRoute };
