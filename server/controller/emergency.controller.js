//FETCH THE DATA that is request and respond from the user (frontend)
const Emergency = require("../services/emergency.services");
const multer = require('multer');
const upload = multer(); // Initialize multer

exports.createEmergencySignal = async (req, res, next) => {
  try {
    console.log('Request Body:', req.body);
    console.log('Uploaded file:', req.file); // Check the uploaded file

    const {
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status
    } = req.body;

    // Check if file is uploaded
    const image = req.file ? {
      public_id: 'unique_id', // Generate a unique ID for the image
      url: req.file.path // Store the file path temporarily, you can replace it with cloudinary response later
    } : null;

    let emergencyReq = await Emergency.createEmergencySignal(
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status,
      image // Pass image data to service
    );
    console.log('Emergency request created:', emergencyReq);

    res.json({ status: true, success: emergencyReq });
  } catch (error) {
    console.error('Error in createEmergencySignal:', error);
    res.status(500).json({ status: false, message: "Internal Server Error" });
    next(error);
  }
}
