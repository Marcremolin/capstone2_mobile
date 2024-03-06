const cloudinary = require('../config/cloudinary');
const EmergencyModel = require('../model/emergency.model');

class EmergencyService {
  static async createEmergencySignal(
    userId,
    residentName,
    currentLocation,
    phoneNumber,
    emergencyType,
    date,
    status,
    file 
  ) {

    try {
      let cloudinaryResponse = null;
      
      if (file) {
        cloudinaryResponse = await this.uploadEmergencyProofImage(file);
      }
      
      const createEmergencySignal = new EmergencyModel({
        userId,
        residentName,
        currentLocation,
        phoneNumber,
        emergencyType,
        date,
        status,
        emergencyProofImage: cloudinaryResponse
          ? {
              url: cloudinaryResponse.secure_url,
              public_id: cloudinaryResponse.public_id
            }
          : null
      });

      const savedEmergencySignal = await createEmergencySignal.save();

      console.log('Saved Emergency Signal:', savedEmergencySignal);

      return savedEmergencySignal;
    } catch (err) {
      console.error('Error in createEmergencySignal:', err);
      throw err;
    }
  }

  static async uploadEmergencyProofImage(file) {
    try {
        const cloudinaryResponse = await cloudinary.uploader.upload(file.path, {
          folder: 'emergency'
        });

        console.log('Cloudinary upload response:', cloudinaryResponse);

        return cloudinaryResponse;
    } catch (error) {
        console.error('Error uploading emergency proof image to Cloudinary:', error);
        throw error;
    }
  }
}

module.exports = EmergencyService;

// const EmergencyModel = require('../model/emergency.model');


// class EmergencyService {
  
//   static async createEmergencySignal(
//     userId,
//     residentName,
//     currentLocation,
//     phoneNumber,
//     emergencyType,
//     date,
//     status,
//     file 
//   ) {

//     try {
//       let cloudinaryResponse = null;
      
//       if (file) {
//         cloudinaryResponse = await this.uploadEmergencyProofImage(file);
//       }
      
//       const createEmergencySignal = new EmergencyModel({
//         userId,
//         residentName,
//         currentLocation,
//         phoneNumber,
//         emergencyType,
//         date,
//         status,
//         emergencyProofImage: cloudinaryResponse
//           ? {
//               url: cloudinaryResponse.secure_url,
//               public_id: cloudinaryResponse.public_id
//             }
//           : null
//       });

//       const savedEmergencySignal = await createEmergencySignal.save();

//       console.log('Saved Emergency Signal:', savedEmergencySignal);

//       return savedEmergencySignal;
//     } catch (err) {
//       console.error('Error in createEmergencySignal:', err);
//       throw err;
//     }
//   }

//   static async uploadEmergencyProofImage(file) {
//     try {
//         const cloudinaryResponse = await cloudinary.uploader.upload(file.path, {
//           folder: 'emergency'
//         });

//         console.log('Cloudinary upload response:', cloudinaryResponse);

//         return cloudinaryResponse;
//     } catch (error) {
//         console.error('Error uploading emergency proof image to Cloudinary:', error);
//         throw error;
//     }
//   }
// }

// module.exports = EmergencyService;
