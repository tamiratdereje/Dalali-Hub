import { File } from "tsoa";

export interface IFileUploadService {
  uploadFile(file: File): Promise<object>;
  deleteFile(file: string): Promise<void>;
}
