import { Document, Model, Query } from "mongoose";
import { Request, Response, NextFunction } from "express";

const advancedResults = (model: Model<Document>, populate: string) => async (
  req: Request,
  res: Response,
  next: NextFunction
) => {
  let query: Query<Document[], Document>;

  const reqQuery = { ...req.query };

  // Copy req query
  const removeFields = ["select", "sort", "page", "limit"];

  // Loop to remove from reqQuery
  removeFields.forEach((param) => delete reqQuery[param]);

  let queryString = JSON.stringify(reqQuery);
  queryString = queryString.replace(/\b(gt|gte|lt|lte|in)\b/g, (match) => `$${match}`);

  // Find resource
  query = model.find(JSON.parse(queryString)).populate(populate);

  // Select fields
  if (req.query.select) {
    const fields = (req.query.select as string).split(",").join(" ");
    query = query.select(fields);
  }

  if (req.query.sort) {
    const sortBy = (req.query.sort as string).split(",").join(" ");
    query = query.sort(sortBy);
  } else {
    query = query.sort("-createdAt");
  }

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

  req.advancedResults = {
    success: true,
    count: results.length,
    pagination,
    data: results,
  };

  next();
};

export default advancedResults;
