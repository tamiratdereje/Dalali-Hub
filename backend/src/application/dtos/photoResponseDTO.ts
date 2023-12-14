import { Types } from "mongoose";

export class PhotoResponseDTO {
    constructor(
      public publicId: string,
      public secureUrl: string,
      public id: Types.ObjectId,
    ) {}
  }
  