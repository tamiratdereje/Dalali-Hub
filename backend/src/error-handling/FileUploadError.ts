import { CustomError } from "@error-custom/CustomError";

export class FileUploadError extends CustomError {
  constructor(message: string) {
    super(message, 500, undefined);
  }
  name: string = "FileUploadError";
}
