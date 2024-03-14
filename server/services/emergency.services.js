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
    imagePath // Add imagePath parameter
  ) {
    try {
      let cloudinaryResponse = null;
      
      // Upload the image to cloudinary if imagePath is provided
      if (imagePath) {
        cloudinaryResponse = await this.uploadEmergencyProofImage(imagePath);
      }
      
      // Create a new emergency signal object
      const createEmergencySignal = new EmergencyModel({
        userId,
        residentName,
        currentLocation,
        phoneNumber,
        emergencyType,
        date,
        status,
        emergencyProofImage: cloudinaryResponse ? { 
          public_id: cloudinaryResponse.public_id,
          url: cloudinaryResponse.secure_url 
        } : null
      });
      
      // Save the emergency signal object to the database
      const savedEmergencySignal = await createEmergencySignal.save();
      
      console.log('Saved Emergency Signal:', savedEmergencySignal);
      
      return savedEmergencySignal;
    } catch (err) {
      console.error('Error in createEmergencySignal:', err);
      throw err;
    }
  }

  static async uploadEmergencyProofImage(imagePath) {
    try {
      console.log('Uploading emergency proof image to Cloudinary...');
      const cloudinaryResponse = await cloudinary.uploader.upload(imagePath, {
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
//     file 
//   ) {

//     try {
//       let cloudinaryResponse = null;
//       let imagePath = null; // Add imagePath variable
      
//       if (file) {
//         cloudinaryResponse = await this.uploadEmergencyProofImage(file);
//         imagePath = cloudinaryResponse ? cloudinaryResponse.url : null; // Set imagePath
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
//             ? {
//                 url: cloudinaryResponse.secure_url,
//                 public_id: cloudinaryResponse.public_id
//               }
//             : null
//     });
    
//     const savedEmergencySignal = await createEmergencySignal.save();
    
//     console.log('Saved Emergency Signal:', savedEmergencySignal);
    
//     return savedEmergencySignal;
    
//     } catch (err) {
//       console.error('Error in createEmergencySignal:', err);
//       throw err;
//     }
//   }
//   static async uploadEmergencyProofImage(file) {
//     try {
//         console.log('Uploading emergency proof image to Cloudinary...');
//         const cloudinaryResponse = await cloudinary.uploader.upload(file.path, {
//           folder: 'emergency'
//         });

//         console.log('Cloudinary upload response:', cloudinaryResponse);

//         return cloudinaryResponse;
//     } catch (error) {
//         console.error('Error uploading emergency proof image to Cloudinary:', error);
//         throw error;
//     }
//    }
// }
// module.exports = EmergencyService;









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