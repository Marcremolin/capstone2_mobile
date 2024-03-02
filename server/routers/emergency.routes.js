const router = require('express').Router(); 
const multer = require('multer');
const EmergencyController = require("../controller/emergency.controller");

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/emergency'); 
  },
  filename: function (req, file, cb) {
    cb(null, file.originalname); 
  }
});

const upload = multer({ storage: storage });

router.post('/emergencySignal', upload.single('emergencyProofImage'), (req, res, next) => {
  console.log('Uploaded filename:', req.file.filename); // Log the uploaded filename
  EmergencyController.createEmergencySignal(req, res, next);
});

module.exports = router;



// const router = require('express').Router(); 
// const multer = require('multer');
// const EmergencyController = require("../controller/emergency.controller");

// const storage = multer.diskStorage({
//   destination: function (req, file, cb) {
//     cb(null, 'uploads/emergency'); 
//   },
//   filename: function (req, file, cb) {
//     cb(null, file.originalname); 
//   }
// });

// const upload = multer({ storage: storage });

// router.post('/emergencySignal', upload.single('emergencyProofImage'), (req, res, next) => {
//   console.log('Uploaded filename:', req.file.filename); // Log the uploaded filename
//   EmergencyController.createEmergencySignal(req, res, next);
// });

// module.exports = router;
