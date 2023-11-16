import { connect } from "mongoose";
import * as dotenv from "dotenv";

export class DBConfig {
  async init() {
    dotenv.config();
    return await this.connect();
  }

  async connect(): Promise<boolean> {
    try {
      const url = process.env.DB_URL;
      console.log("DB URL: ====>>  ====>> ", url);
      await connect(url);
      console.log("Connected to database.")
      return true;
    } catch (error) {
      console.error(error);
      return false;
    }
  }
}
