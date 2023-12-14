import { Document, Model, Query } from "mongoose";
import { Request, Response, NextFunction } from "express";
import { HouseEntity } from "@entities/HouseEntity";
import { asyncHandler } from "./async.handler.middleware";

export const advancedResults = <T>
  (model: Model<T>, populate: string) => 
  asyncHandler(
    async (req: Request, res: Response, next: NextFunction) => {
      let query: Query<T[], T>;
  
      const reqQuery = { ...req.query };
  
      // Copy req query
      const removeFields = ["select", "sort", "page", "limit"];
  
      // Loop to remove from reqQuery
      removeFields.forEach((param) => delete reqQuery[param]);
  
      let queryString = JSON.stringify(reqQuery);
      queryString = queryString.replace(
        /\b(gt|gte|lt|lte|in)\b/g,
        (match) => `$${match}`
      );
      
      // Pagination
      const page = parseInt(req.query.page as string, 10) || 1;
      const limit = parseInt(req.query.limit as string, 10) || 10;
  
      req.queryString = queryString;
      req.populate = populate;
      req.page = page;
      req.limit = limit;
  
      next();
    }
  )

