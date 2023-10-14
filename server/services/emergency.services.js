//STORE THE DATA ENTERED BY A USER (Frontend)

const EmergencyModel = require('../model/emergency.model')

const jwt = require('jsonwebtoken')
class EmergencyService{
    static async createEmergencySignal(
        userId,
        currentLocation,
        contactNum,
        emergencyType,
        date,
        status
    ){

        try{
            const createEmergencySignal = new EmergencyModel({  
                userId,
                currentLocation,
                contactNum,
                emergencyType,
                date,
                status
              });

                return await createEmergencySignal.save();


        }catch(err){

        }
    }

    //Make call to MongoDB database by making use of MODEL 
// ------- Check if the user email exist in the database ---------- 
static async checkuser(userId,contactNum) {
    try {
      const user = await UserModel.findOne({userId,contactNum });
      if (!user) {
        console.log(`User not found for userId: ${userId,contactNum}`);
      }
      return user;
    } catch (error) {
      console.error('Error in checkuser:', error);
      throw error;
    }
  }
  

// ------- data from user controller to generate a JWT token -------
static async generateToken(tokenData,secretKey,jwt_expire){
    return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expire});


}

}

module.exports = EmergencyService;

