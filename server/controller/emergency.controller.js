
const EmergencyService = require("../services/emergency.services");

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
      status
    } = req.body;
    const date = new Date(); // Get current date
    const formattedDate = formatDate(date); // Format date as per your requirement
    let emergencyProofImage = null;
    if (req.file) {
      console.log('Uploaded File:', req.file);
      emergencyProofImage = req.file;
    }

    const savedEmergencySignal = await EmergencyService.createEmergencySignal(
      userId,
      residentName,
      currentLocation,
      phoneNumber,
      emergencyType,
      formattedDate,
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


function formatDate(date) {
  const formattedDate = date.toLocaleString('en-US', {
    year: 'numeric',
    month: '2-digit',
    day: '2-digit',
    hour: '2-digit',
    minute: '2-digit',
    second: '2-digit',
    hour12: true 
  });

  return formattedDate;
}














// const Emergency = require("../services/emergency.services");

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
//     const date = new Date().toLocaleString('en-US', { timeZone: 'UTC' }); // Format date

//     // Make sure to handle the file correctly
//     const imagePath = req.file ? req.file.path : null;
//     const savedEmergencySignal = await Emergency.createEmergencySignal(
//       userId,
//       residentName,
//       currentLocation,
//       phoneNumber,
//       emergencyType,
//       date,
//       status,
//       imagePath // Pass the imagePath received from the front-end
//     );

//     console.log('Emergency request created:', savedEmergencySignal);

//     // Send the image path in the response
//     res.json({ status: true, success: savedEmergencySignal, imagePath });
//   } catch (error) {
//     console.error('Error in createEmergencySignal:', error); 
//     next(error);
//   }
// }


// const Emergency = require("../services/emergency.services");

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

//     // Make sure to handle the file correctly
//     const imagePath = req.file ? req.file.path : null;
//     const savedEmergencySignal = await Emergency.createEmergencySignal(
//       userId,
//       residentName,
//       currentLocation,
//       phoneNumber,
//       emergencyType,
//       date,
//       status,
//       imagePath // Pass the imagePath received from the front-end
//     );

//     console.log('Emergency request created:', savedEmergencySignal);

//     // Send the image path in the response
//     res.json({ status: true, success: savedEmergencySignal, imagePath });
//   } catch (error) {
//     console.error('Error in createEmergencySignal:', error); 
//     next(error);
//   }
// }

// WORKING TO ---- 


// const Emergency = require("../services/emergency.services");

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

//     // Make sure to handle the file correctly
//     const emergencyProofImage = req.file ? req.file.path : null;
//     const savedEmergencySignal = await Emergency.createEmergencySignal(
//       userId,
//       residentName,
//       currentLocation,
//       phoneNumber,
//       emergencyType,
//       date,
//       status,
//       imagePath // Pass the imagePath received from the front-end
//     );

//     console.log('Emergency request created:', savedEmergencySignal);

//     res.json({ status: true, success: savedEmergencySignal });
//   } catch (error) {
//     console.error('Error in createEmergencySignal:', error); 

//     next(error);
//   }
// }


















// const Emergency = require("../services/emergency.services");



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
