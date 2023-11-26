import mongoose, {Types} from "mongoose";

export interface IBaseEntity {
  _id: Types.ObjectId;
  createdBy: mongoose.Schema.Types.ObjectId | undefined;
}
