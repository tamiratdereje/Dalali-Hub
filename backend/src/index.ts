import * as http from "http";
import * as express from 'express';
import { ExpressConfig } from "@express-config";
import { config } from "dotenv";
import { DBConfig } from "config/DB.config";


const main = async () => {
  const isDbInitialized = await new DBConfig().init();
  if (!isDbInitialized) {
    console.error("Database connection failed");
    return;
  }
  const app = express();
  new ExpressConfig(app).init();

  const httpServer = http.createServer(app);
  httpServer.listen(process.env.PORT, () => {
    console.log(`Server is running on port ${process.env.PORT}`);
  });
};

config();
main();
