//STORE THE DATA ENTERED BY A USER (Frontend)
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
    image // Receive image data
  ){
    try {
      const createEmergencySignal = new EmergencyModel({  
        userId,
        residentName,
        currentLocation,
        phoneNumber,
        emergencyType,
        date,
        status,
        proofOfEmergency: image // Store image data in the database
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
