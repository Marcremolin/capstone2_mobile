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
    emergencyProofImage // Add emergencyProofImage parameter
  ) {
    try {
      // Call the method to upload emergency proof image
      const uploadedProofImage = await this.uploadEmergencyProofImage(emergencyProofImage);

      // Create the emergency signal document
      const createEmergencySignal = new EmergencyModel({
        userId,
        residentName,
        currentLocation,
        phoneNumber,
        emergencyType,
        date,
        status,
        emergencyProofImage: uploadedProofImage.secure_url // Store the Cloudinary URL in the document
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
}

module.exports = EmergencyService;
