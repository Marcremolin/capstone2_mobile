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
    
    let base64ImageData = null;
    if (req.file) {
      console.log('Uploaded File:', req.file);
      // Read the file and encode it as base64
      const fileData = fs.readFileSync(req.file.path);
      base64ImageData = fileData.toString('base64');
    }

    const savedEmergencySignal = await Emergency.createEmergencySignal(
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      date,
      status,
      base64ImageData // Pass base64 image data to the service
    );

    console.log('Emergency request created:', savedEmergencySignal);

    res.json({ status: true, success: savedEmergencySignal });
  } catch (error) {
    console.error('Error in createEmergencySignal:', error); 
    next(error);
  }
}
// exports.createEmergencySignal = async (req, res, next) => {
//   try {
//     console.log('Request Body:', req.body); 
//     console.log('Uploaded File:', req.file); 

//     const {
//       userId,
//       residentName,
//       currentLocation,
//       phoneNumber,
//       emergencyType,
//       date,
//       status
//     } = req.body;
//     let emergencyProofImage = null;
//     if (req.file) {
//       console.log('Uploaded File:', req.file);
//       emergencyProofImage = req.file;
//     }

//     const savedEmergencySignal = await Emergency.createEmergencySignal(
//       userId,
//       residentName,
//       currentLocation,
//       phoneNumber,
//       emergencyType,
//       date,
//       status,
//       emergencyProofImage
//     );

//     console.log('Emergency request created:', savedEmergencySignal);

//     res.json({ status: true, success: savedEmergencySignal });
//   } catch (error) {
//     console.error('Error in createEmergencySignal:', error); 

//     next(error);
//   }
// }

