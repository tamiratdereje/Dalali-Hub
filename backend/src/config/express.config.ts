import { isDevEnvironment, isProdEnvironment } from "@helpers/Constants";
import * as bodyParser from "body-parser";
import * as cors from "cors";
import { Express } from "express";
import { errorHandler } from "webapi/middlewares/error.handler.middleware";
import { authRoute } from "webapi/routes/auth.route";
import morgan = require("morgan");
import { houseRoute } from "webapi/routes/house.route";
import { hallRoute } from "webapi/routes/hall.route";
import { officeRoute } from "webapi/routes/office.route";
import { landRoute } from "webapi/routes/land.route";
import { feedRoute } from "webapi/routes/feed.route";
import { vehicleRoute } from "webapi/routes/vehicle.route";
import { realStateRoute } from "webapi/routes/realState.route";

export class ExpressConfig {
  private app: Express;
  private port = Number(process.env.PORT) || 3000;

  constructor(express: Express) {
    this.app = express;
  }

  public async init(): Promise<void> {
    try {
      if (isDevEnvironment()) {
        this.app.use(morgan("combined"));
      } else if (isProdEnvironment()) {
        this.app.use(morgan("tiny"));
      }

      this.app.use(bodyParser.json());
      this.app.use(bodyParser.urlencoded({ extended: false }));
      this.app.use(cors({ origin: "*" }));

      this.app.use("/api/v1/auth", authRoute);
      this.app.use("/api/v1/houses", houseRoute);
      this.app.use("/api/v1/hall", hallRoute);
      this.app.use("/api/v1/office", officeRoute);
      this.app.use("/api/v1/land", landRoute);
      this.app.use("/api/v1/feed", feedRoute);
      this.app.use("/api/v1/vehicle", vehicleRoute);
      this.app.use("/api/v1/realstates", realStateRoute);
      this.app.use("/api/v1/all", (req, res) => {
        res.send("Hello World!");
      });

      this.app.use(errorHandler);
    } catch (error) {
      console.error(error);
    }
  }
}
