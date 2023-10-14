const Emergency = require("../services/emergency.services");

exports.createEmergencySignal = async (req, res, next) => {
  try {
    console.log('Request Body:', req.body); 

    const {
      userId,
      currentLocation,
      contactNum,
      emergencyType,
      date,
      status
    } = req.body;

    if (!userId || typeof userId !== 'string') {
      return res.status(400).json({ status: false, error: 'Invalid userId' });
    }
    if (!currentLocation || typeof currentLocation !== 'string') {
      return res.status(400).json({ status: false, error: 'Invalid currentLocation' });
    }
    if (!contactNum || typeof contactNum !== 'string') {
      return res.status(400).json({ status: false, error: 'Invalid contactNum' });
    }
    if (!emergencyType || typeof emergencyType !== 'string') {
      return res.status(400).json({ status: false, error: 'Invalid emergencyType' });
    }
    if (!date || !Date.parse(date)) {
      return res.status(400).json({ status: false, error: 'Invalid date' });
    }
    if (status && typeof status !== 'string') {
      return res.status(400).json({ status: false, error: 'Invalid status' });
    }

    let emergencyReq = await Emergency.createEmergencySignal(
      userId,
      currentLocation,
      contactNum,
      emergencyType,
      date,
      status
    );

    res.json({ status: true, success: emergencyReq });
  } catch (error) {
    next(error);
  }
}
