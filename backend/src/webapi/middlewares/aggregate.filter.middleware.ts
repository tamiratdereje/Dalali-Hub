import { Document, Model, Query } from "mongoose";
import { Request, Response, NextFunction } from "express";
import { asyncHandler } from "./async.handler.middleware";
import { raw } from "body-parser";

export const advancedResults = <T>(model: Model<T>, populate: string) =>
  asyncHandler(async (req: Request, res: Response, next: NextFunction) => {
    let query: Query<T[], T>;

    let reqQuery = {};
    reqQuery = { ...req.query };
    let sortParams = req.query.sort ? req.query.sort : "-createdAt";
    console.log("sortParams \n\n\n\n\n\n\n\\n\n", sortParams);
    const filterParameter = req.query.filterParameter;
    console.log("reqQuery \n\n\n\n\n\n\n\\n\n");
    console.log(reqQuery);
    console.log(req.query.filterParameter);
    console.log("reqQuery \n\n\n\n\n\n\n\\n\n");
    // Copy req query
    const removeFields = ["select", "sort", "page", "limit"];

    // delete reqQuery.filterParameter
    delete (reqQuery as any)["filterParameter"];

    reqQuery = { ...reqQuery, ...(filterParameter as any) };

    console.log("reqQuery After reset \n\n\n\n  \n\n\n\\n\n", reqQuery);
    // Loop to remove from reqQuery
    removeFields.forEach((param) => delete (reqQuery as any)[param]);

    let queryString = JSON.stringify(reqQuery);

    queryString = queryString.replace(
      /\b(gt|gte|lt|lte|in)\b/g,
      (match) => `$${match}`
    );

    // Pagination
    const page = parseInt(req.query.page as string, 10) || 1;
    const limit = parseInt(req.query.limit as string, 10) || 10;

    console.log("queryString \n\n\n\n\n\n\n\\n\n");
    console.log(queryString);
    console.log("queryString \n\n\n\n\n\n\n\\n\n");
    req.queryString = queryString;
    req.populate = populate;
    req.page = page;
    req.limit = limit;
    req.sort = sortParams as string;

    next();
  });
