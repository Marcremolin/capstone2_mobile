exports.createEmergencySignal = async (req, res, next) => {
  try {
    console.log('Request Body:', req.body);

    const {
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status,
      emergencyProofImage // Add emergencyProofImage to the destructuring
    } = req.body;

    // Call the service method to create emergency signal and upload emergency proof image
    let emergencyReq = await Emergency.createEmergencySignal(
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status,
      emergencyProofImage // Pass emergencyProofImage to the service method
    );

    console.log('Emergency request created:', emergencyReq);

    res.json({ status: true, success: emergencyReq });
  } catch (error) {
    next(error);
  }
}
