const router = require('express').Router(); 
const multer = require('multer');
const EmergencyController = require("../controller/emergency.controller");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/emergency'); 
  },
  filename: function (req, file, cb) {
    // Ensure file.originalname is not undefined before concatenating
    const originalname = file.originalname ? file.originalname : '';
    cb(null, Date.now() + '-' + originalname); 
  }
});

const upload = multer({ storage: storage });

router.post('/emergencySignal', upload.single('emergencyProofImage'), EmergencyController.createEmergencySignal);

module.exports = router;
