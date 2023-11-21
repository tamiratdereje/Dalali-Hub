// validation error class for each property from class-validator
// map each error messsage to a string

import { ValidationError } from "class-validator";
import { StatusCodes } from "http-status-codes";
import { CustomError } from "./CustomError";

export class CustomValidationError extends CustomError {
  constructor(message: string) {
    super(message, StatusCodes.BAD_REQUEST, undefined);
  }

  public static Instance(errors: ValidationError[]): CustomValidationError {
    const message = errors.map((error) => {
      
      return JSON.stringify(Object.values(error.constraints));
    });
    console.log(message.join("\n"));
    return new CustomValidationError(message[0].substring(2, message[0].length - 2).replace(/"/g, ''));
  }
}
