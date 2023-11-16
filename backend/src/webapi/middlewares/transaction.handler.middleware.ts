import { Request, Response, NextFunction } from "express";
import mongoose from "mongoose";

export const transactionHandler = async <T>(fn: any): Promise<T> => {
  const session = await mongoose.startSession();
  session.startTransaction();
  try {
    const result = await fn;
    await session.commitTransaction();
    session.endSession();
    return result;
  } catch (error) {
    await session.abortTransaction();
    session.endSession();
    throw error;
  }
};
