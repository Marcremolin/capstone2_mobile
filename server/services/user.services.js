const UserModel = require('../model/user.model')
const jwt = require('jsonwebtoken')
const nodemailer = require("nodemailer"); 
require("dotenv").config(); 
const config = require('../config/config');



class UserService {

  static async registerUser( 
    lastName,
    firstName,
    middleName,
    suffix,
    houseNumber,
    barangay,
    cityMunicipality,
    district,
    province,
    region,
    phoneNumber,
    email,
    nationality,
    civilStatus,
    highestEducation,
    employmentStatus,
    homeOwnership,
    residentClass,
    birthPlace,
    age,
    dateOfBirth,
    sex,
    companyName,
    position,
    votersRegistration, 
    status,
    password,
    type

  )
  
   {
    try {

       // Generate a unique user ID
       const currentDate = new Date().toISOString().slice(0, 10).replace(/-/g, '');
       const lastCustomIdDoc = await UserModel.findOne().sort({ _id: -1 });
       let newCustomId = currentDate + '01';
       if (lastCustomIdDoc) {
         const lastIncrement = parseInt(lastCustomIdDoc._id.slice(-2));
         const newIncrement = (lastIncrement + 1).toString().padStart(2, '0');
         newCustomId = currentDate + newIncrement;
       }

       //nodemailer stuff
       let transporter = nodemailer.createTransport({
        service: "gmail",
        auth: {
          user: process.env.AUTH_EMAIL, 
          pass: process.env.AUTH_PASS, 
        }
       })
       //testing success
       transporter.verify((error, success) => {
          if(error){
            console.log(error); 
          } else{
            console.log("Ready for messages");
            console.log(success);
          }
       })
            
 
    


       //store the data that the user has passed
      const createUser = new UserModel({
            _id: newCustomId,
            lastName,
            firstName,
            middleName,
            suffix,
            houseNumber,
            barangay,
            cityMunicipality,
            district,
            province,
            region,
            phoneNumber,
            email,
            nationality,
            civilStatus,
            highestEducation,
            employmentStatus,
            homeOwnership,
            residentClass,
            birthPlace,
            age,
            dateOfBirth,
            sex,
            companyName,
            position,
            votersRegistration, 
            status,
            password,
            type,
            verified: false,
        

      });

      return await createUser.save();


    } catch (err) {
        throw (err)
    }
  }

  //Make call to MongoDB database by making use of MODEL 
  // ------- Check if the user email exist in the database ---------- 
  static async checkuser(email) {
    try {
      const user = await UserModel.findOne({ email });
      if (!user) {
        console.log(`User not found for email: ${email}`);
      }
      return user;
    } catch (error) {
      console.error('Error in checkuser:', error);
      throw error;
    }
  }


  static async login(email, password) {
    try {
      const user = await UserModel.findOne({ email });
      if (!user) {
        console.log(`User not found for email: ${email}`);
        return null;
      }
  
      const isMatch = await user.comparePassword(password);
      console.log('Entered Password Length:', password.length);
      console.log('Hashed Password Length:', user.password.length);
      console.log('Password match:', isMatch);
      if (isMatch) {
        let tokenData = {
          _id: user._id, 
          email: user.email, 
          };
        const token = this.generateToken(tokenData, config.secretKey, "1D");
        
        console.log('Generated Token:', token); // Log the generated token

        return token;
      } else {
        console.log('Password does not match');
        return null;
      }
    } catch (error) {
      console.error('Error in login:', error);
      throw error;
    }
  }

  
  
// ------- data from user controller to generate a JWT token -------
static async generateToken(tokenData,secretKey,jwt_expire){
    return jwt.sign(tokenData,secretKey,{expiresIn:jwt_expire});


}
}

module.exports = UserService;

