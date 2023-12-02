import { Document, Model, Query } from "mongoose";
import { Request, Response, NextFunction } from "express";
import { HouseEntity } from "@entities/HouseEntity";

export const advancedResults = <T>
  (model: Model<T>, populate: string) =>
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
    
    // Find resource
    query = model.find(JSON.parse(queryString)).populate(populate);
    
    // Pagination
    const page = parseInt(req.query.page as string, 10) || 1;
    const limit = parseInt(req.query.limit as string, 10) || 10;
    const startIndex = (page - 1) * limit;
    const endIndex = page * limit;
    const total = await model.countDocuments();
    
    query = query.skip(startIndex).limit(limit);

    // Executing query
    const results = await query;

    // Pagination result
    const pagination: { [key: string]: { page: number; limit: number } } = {};

    if (endIndex < total) {
      pagination.next = {
        page: page + 1,
        limit,
      };
    }
    if (startIndex > 0) {
      pagination.prev = {
        page: page - 1,
        limit,
      };
    }
    req.customQuery = JSON.parse(queryString);

    req.advancedResults = {
      success: true,
      count: results.length,
      pagination,
      data: results,
    };

    next();
  };

