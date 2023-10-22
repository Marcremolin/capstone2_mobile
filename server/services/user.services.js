const UserModel = require('../model/user.model')
const jwt = require('jsonwebtoken')
class UserService {

  static async registerUser( 
    lastName,
    firstName,
    middleName,
    houseNumber,
    barangay,
    city,
    district,
    street,
    region,
    nationality,
    birthplace,
    age,
    companyName,
    position,
    phoneNumber,
    emailAddress,
    civilStatus,
    highestEducation,
    employmentStatus,
    password,
    dateOfBirth,
    gender,
    homeOwnership,
    residentClass,
    votersRegistration

  ) {

    try { //store the data that the user has passed

      const createUser = new UserModel({
        lastName,
        firstName,
        middleName,
        houseNumber,
        barangay,
        city,
        district,
        street,
        region,
        nationality,
        birthplace,
        age,
        companyName,
        position,
        phoneNumber,
        emailAddress,
        civilStatus,
        highestEducation,
        employmentStatus,
        password,
        dateOfBirth,
        gender,
        homeOwnership,
        residentClass,
        votersRegistration

      });

      return await createUser.save();


    } catch (err) {
        throw (err)
    }
  }

  //Make call to MongoDB database by making use of MODEL 
  // ------- Check if the user email exist in the database ---------- 
  static async checkuser(emailAddress) {
    try {
      const user = await UserModel.findOne({ emailAddress });
      if (!user) {
        console.log(`User not found for email: ${emailAddress}`);
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

module.exports = UserService;

