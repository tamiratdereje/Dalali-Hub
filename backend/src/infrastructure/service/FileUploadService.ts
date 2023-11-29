import { File } from "tsoa";
import { cloudinary } from "../../config/cloudinary.config";
import { FileUploadError } from "@error-custom/FileUploadError";
import { IFileUploadService } from "@interfaces/services/IFileService";
import { uploadedFileDTO } from "@dtos/uploadedFileDTO";

export class FileUploadService implements IFileUploadService {
  public async uploadFile(file: File): Promise<uploadedFileDTO> {
    try {
      let result = await cloudinary.uploader.upload(file.path, {
        folder: "houses",
      });
      return new uploadedFileDTO(result.public_id, result.secure_url);
    } catch (err) {
      throw new FileUploadError("Error happened while uploading file");
    }
  }

  public async deleteFile(file: string): Promise<void> {
    cloudinary.uploader.destroy(file).catch((err) => {
      throw new FileUploadError("Error happened while deleting file");
    });
  }
}
