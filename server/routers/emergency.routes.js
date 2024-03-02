const router = require('express').Router(); 
const multer = require('multer');
const EmergencyController = require("../controller/emergency.controller");

// Multer configuration for handling file uploads
const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/emergency'); // Specify the directory where files should be uploaded
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname); // Use the original filename for storing the file
  }
});

const upload = multer({ storage: storage });

// Route handler for creating emergency signal
router.post('/emergencySignal', upload.single('emergencyProofImage'), EmergencyController.createEmergencySignal);

module.exports = router;
