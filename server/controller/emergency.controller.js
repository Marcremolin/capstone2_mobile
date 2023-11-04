//FETCH THE DATA that is request and respond from the user (frontend)

const Emergency = require("../services/emergency.services");

exports.createEmergencySignal = async (req, res, next) => {
  try { //pass the data from the services 
    console.log('Request Body:', req.body); 

    const {
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status
    } = req.body;

  

    let emergencyReq = await Emergency.createEmergencySignal(
      userId,
      residentName,

      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status
    );
    console.log('Emergency request created:', emergencyReq);

    res.json({ status: true, success: emergencyReq });
  } catch (error) {
    next(error);
  }
}
