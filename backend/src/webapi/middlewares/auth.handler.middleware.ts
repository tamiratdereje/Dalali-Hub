import { CustomError } from "@error-custom/CustomError";
import { getKeyStore } from "config/create_key_store";
import { NextFunction, Request, Response } from "express";
import { get } from "http";
import { StatusCodes } from "http-status-codes";
import * as jwt from "jsonwebtoken";
import * as jtp from "jwk-to-pem";

export async function protectRoute(req: Request, _: Response, next: NextFunction)  {
  const authHeader = req.headers["authorization"];
  let token = authHeader && authHeader.split(" ")[1];
  if (!token)
    return next(
      new CustomError("Access denied", StatusCodes.UNAUTHORIZED, undefined),
    );

  var keyStore: any = (await getKeyStore()).toJSON();
  var key = keyStore.keys[0];
  var publicKey = jtp(key);


  jwt.verify(token, publicKey, (err: Error, payload: any) => {
    console.log("PAYLOAD", payload);
    console.log("ERROR", err);
    if (err)
      return next(
        new CustomError("Access denied", StatusCodes.UNAUTHORIZED, err.stack),
      );
    req.userId = payload.id;
    next();
  });
}
