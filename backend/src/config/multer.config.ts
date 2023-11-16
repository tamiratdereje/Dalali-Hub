import * as multer from "multer";

const storage = multer.diskStorage({
  filename: function (req, file, cb) {
    //TODO: Add more filters
    cb(null, file.originalname);
  },
});

const upload = multer({ storage: storage });

export default upload;
