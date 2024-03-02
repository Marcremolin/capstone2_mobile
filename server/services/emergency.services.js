const cloudinary = require('../config/cloudinary');
const EmergencyModel = require('../model/emergency.model');
const fs = require('fs');
const path = require('path');

class EmergencyService {
  static async createEmergencySignal(
    userId,
    residentName,
    currentLocation,
    phoneNumber,
    emergencyType,
    date,
    status,
    emergencyProofImage 
  ) {
    try {
      const uploadedProofImage = await this.uploadEmergencyProofImage(emergencyProofImage);
      const createEmergencySignal = new EmergencyModel({
        userId,
        residentName,
        currentLocation,
        phoneNumber,
        emergencyType,
        date,
        status,
        emergencyProofImage: { // Include URL and public ID in the emergencyProofImage object
          url: uploadedProofImage.secure_url,
          public_id: uploadedProofImage.public_id
        }
      });

      const savedEmergencySignal = await createEmergencySignal.save();

      console.log('Saved Emergency Signal:', savedEmergencySignal);

      return savedEmergencySignal;
    } catch (err) {
      console.error('Error in createEmergencySignal:', err);
      throw err;
    }
  }

  static async uploadEmergencyProofImage(emergencyProofImage) {
    try {
      // Check permissions before attempting to write the file
      const uploadDirectory = path.join(__dirname, '..', 'uploads', 'emergency');
      await this.checkPermissions(uploadDirectory);

      // Upload emergency proof image to Cloudinary
      const cloudinaryResponse = await cloudinary.uploader.upload(
        `uploads/emergency/${emergencyProofImage.filename}`,
        { folder: 'emergency' }
      );

      console.log('Emergency proof image uploaded to Cloudinary:', cloudinaryResponse);

      return cloudinaryResponse; // Return the Cloudinary response
    } catch (error) {
      console.error('Error uploading emergency proof image:', error);
      throw error;
    }
  }

  static async checkPermissions(directory) {
    return new Promise((resolve, reject) => {
      fs.access(directory, fs.constants.W_OK, (err) => {
        if (err) {
          console.error(`Error: Insufficient permissions to write to ${directory}`);
          reject(err);
        } else {
          console.log(`Permissions OK for ${directory}`);
          resolve();
        }
      });
    });
  }
}

module.exports = EmergencyService;
