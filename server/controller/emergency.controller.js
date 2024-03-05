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

    // Pass the file to the service function
    const savedEmergencySignal = await Emergency.createEmergencySignal(
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status,
      req.file // Pass the file directly
    );

    console.log('Emergency request created:', savedEmergencySignal);

    res.json({ status: true, success: savedEmergencySignal });
  } catch (error) {
    console.error('Error in createEmergencySignal:', error); // Log any errors
    next(error);
  }
}
