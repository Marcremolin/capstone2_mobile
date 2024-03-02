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
    emergencyProofImage 
) {
    try {
        // Upload emergency proof image to Cloudinary
        const cloudinaryResponse = await cloudinary.uploader.upload(emergencyProofImage.path, {
            folder: 'emergency'
        });

        console.log('Emergency proof image uploaded to Cloudinary:', cloudinaryResponse);

        const createEmergencySignal = new EmergencyModel({
            userId,
            residentName,
            currentLocation,
            phoneNumber,
            emergencyType,
            date,
            status,
            emergencyProofImage: { // Include URL and public ID in the emergencyProofImage object
                url: cloudinaryResponse.secure_url,
                public_id: cloudinaryResponse.public_id
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

}

module.exports = EmergencyService;
