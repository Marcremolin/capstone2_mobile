//STORE THE DATA ENTERED BY A USER (Frontend)

const EmergencyModel = require('../model/emergency.model')

const jwt = require('jsonwebtoken')
class EmergencyService{
    static async createEmergencySignal(
        userId,
        currentLocation,
        phoneNumber,
        emergencyType,
        date,
        status
    ){

        try{
            const createEmergencySignal = new EmergencyModel({  
                userId,
                currentLocation,
                phoneNumber,
                emergencyType,
                date,
                status
              });

              const savedEmergencySignal = await createEmergencySignal.save();

      // Log the saved document
      console.log('Saved Emergency Signal:', savedEmergencySignal);

      return savedEmergencySignal; // Return the saved document
    } catch (err) {
      console.error('Error in createEmergencySignal:', err);
      throw err; // Re-throw the error
    }
  }
}
module.exports = EmergencyService;

