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
    file // Receive the file directly
  ) {
    try {
      const cloudinaryResponse = await this.uploadEmergencyProofImage(file);
      
      // Create EmergencyModel with Cloudinary response
      const createEmergencySignal = new EmergencyModel({
        userId,
        residentName,
        currentLocation,
        phoneNumber,
        emergencyType,
        date,
        status,
        emergencyProofImage: {
          url: cloudinaryResponse.secure_url,
          public_id: cloudinaryResponse.public_id
        }
      });

      // Save to database
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
        // Upload emergency proof image to Cloudinary
        const cloudinaryResponse = await cloudinary.uploader.upload(file.path, {
          folder: 'emergency'
        });

        console.log('Cloudinary upload response:', cloudinaryResponse);

        return cloudinaryResponse; // Return the Cloudinary response
    } catch (error) {
        console.error('Error uploading emergency proof image to Cloudinary:', error);
        throw error;
    }
  }
}

module.exports = EmergencyService;


// const cloudinary = require('../config/cloudinary');
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
//     emergencyProofImage 
//   ) {
//     try {
//       const uploadedProofImage = await this.uploadEmergencyProofImage(emergencyProofImage); // Pass emergencyProofImage object
//       const createEmergencySignal = new EmergencyModel({
//         userId,
//         residentName,
//         currentLocation,
//         phoneNumber,
//         emergencyType,
//         date,
//         status,
//         emergencyProofImage: { // Include URL and public ID in the emergencyProofImage object
//           url: uploadedProofImage.secure_url,
//           public_id: uploadedProofImage.public_id
//         }
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
//         // Upload emergency proof image to Cloudinary
//         const cloudinaryResponse = await cloudinary.uploader.upload(
//             `uploads/emergency/${file.filename}`, // Using the filename from multer
//             { folder: 'emergency' }
//         );

//         console.log('Cloudinary upload response:', cloudinaryResponse);

//         return cloudinaryResponse; // Return the Cloudinary response
//     } catch (error) {
//         console.error('Error uploading emergency proof image to Cloudinary:', error);
//         throw error;
//     }
// }


// }

// module.exports = EmergencyService;