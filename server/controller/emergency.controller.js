const Emergency = require("../services/emergency.services");

exports.createEmergencySignal = async (req, res, next) => {
  try {
    console.log('Request Body:', req.body); 
    console.log('Uploaded File:', req.file); // Check if the file is correctly received

    const {
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status
    } = req.body;

    const cloudinaryResponse = req.file; // Access the Cloudinary response from req.file

    // Extract URL and public ID from the Cloudinary response
    const emergencyProofImage = {
      url: cloudinaryResponse.secure_url,
      public_id: cloudinaryResponse.public_id
    };

    let emergencyReq = await Emergency.createEmergencySignal(
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status,
      emergencyProofImage // Pass emergencyProofImage to the service function
    );

    console.log('Emergency request created:', emergencyReq);

    res.json({ status: true, success: emergencyReq });
  } catch (error) {
    next(error);
  }
}
