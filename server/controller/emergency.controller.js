const Emergency = require("../services/emergency.services");

exports.createEmergencySignal = async (req, res, next) => {
  try {
    console.log('Request Body:', req.body); 
    console.log('Uploaded File:', req.file); 

    const {
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status
    } = req.body;
    let emergencyProofImage = null;
    if (req.file) {
      console.log('Uploaded File:', req.file);
      emergencyProofImage = req.file;
    }

    const savedEmergencySignal = await Emergency.createEmergencySignal(
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status,
      emergencyProofImage
    );

    console.log('Emergency request created:', savedEmergencySignal);

    res.json({ status: true, success: savedEmergencySignal });
  } catch (error) {
    console.error('Error in createEmergencySignal:', error); 

    next(error);
  }
}
