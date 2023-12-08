import { Hall } from "@entities/HallEntity";
import { House } from "@entities/HouseEntity";
import { Land } from "@entities/LandEntity";
import { Office } from "@entities/OfficeEntity";
import { Photo } from "@entities/PhotoEntity";
import { HallRepository } from "@repositories/HallRepository";
import { HouseRepository } from "@repositories/HouseRepository";
import { LandRepository } from "@repositories/LandRepository";
import { OfficeRepository } from "@repositories/OfficeRepository";
import { PhotoRepository } from "@repositories/PhotoRepository";
import { Router } from "express";
import { FeedController } from "webapi/controllers/feed.controller";


const houseRepository = new HouseRepository(House);
const hallRepository = new HallRepository(Hall);
const officeRepository = new OfficeRepository(Office);
const photoRepository = new PhotoRepository(Photo);
const landRepository = new LandRepository(Land);


const feedRoute = Router();
const feedController = new FeedController(
    houseRepository,
    hallRepository,
    photoRepository,
    landRepository,
    officeRepository

);

feedRoute.get("/", feedController.getAllFeeds);

export {feedRoute}