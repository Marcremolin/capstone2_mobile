//FETCH THE DATA that is request and respond from the user (frontend)

const Emergency = require("../services/emergency.services");
exports.createEmergencySignal = async (req, res, next) => {
  try {
    const { userId, residentName, currentLocation, phoneNumber, emergencyType, date, status } = req.body;
    let userImage = null;

    if (req.file) {
      // If a file is uploaded, set the userImage
      userImage = {
        public_id: req.file.public_id, // Assuming this comes from Cloudinary
        url: req.file.secure_url // Assuming this comes from Cloudinary
      };
    }

    const emergencyReq = await Emergency.createEmergencySignal(
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status,
      userImage
    );

    console.log('Emergency request created:', emergencyReq);

    res.json({ status: true, success: emergencyReq });
  } catch (error) {
    next(error);
  }
}