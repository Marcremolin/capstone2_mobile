const UserModel = require('../model/user.model')
const jwt = require('jsonwebtoken')
const nodemailer = require("nodemailer"); 
require("dotenv").config(); 
const config = require('../config/config');
const cloudinary = require('../config/cloudinary');
const { v4: uuidv4 } = require('uuid');


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
    userImage,
    status,
    password,
    type
  ) {
    try {
      // Generate a unique user ID
      const currentDate = new Date().toISOString().slice(0, 10).replace(/-/g, '');
      const lastCustomIdDoc = await UserModel.findOne().sort({ _id: -1 });
      let newCustomId = currentDate + '0001';
      if (lastCustomIdDoc) {
        const lastIncrement = parseInt(lastCustomIdDoc._id.slice(-2));
        const newIncrement = (lastIncrement + 1).toString().padStart(2, '0');
        newCustomId = currentDate + newIncrement;
      }

      // Nodemailer setup
      let transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: process.env.AUTH_EMAIL,
          pass: process.env.AUTH_PASS,
        },
      });

      transporter.verify((error, success) => {
        if (error) {
        } else {
          console.log('Ready for messages');
          console.log(success);
        }
      });

    const cloudinaryResponse = await cloudinary.uploader.upload(
      `uploads/profile/${userImage.filename}`,
      { folder: 'profile' } 
    );

    

      // Create a new user instance and set the userImage
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
        userImage: {
          public_id: cloudinaryResponse.public_id, 
          url: cloudinaryResponse.secure_url 
        },
        
        filename: {
          public_id: cloudinaryResponse.public_id, 
          url: cloudinaryResponse.secure_url 
        },
        

        status,
        password,
        type,
        verified: false,
      });

     

      // Save the user data in the database
      await createUser.save();

      return createUser;
    } catch (err) {
      throw err;
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



// ------------- UPDATE PROFILE ---------------- 
static async updateUserImage(userId, userImage) {
  try {
    const user = await UserModel.findById(userId);

    if (!user) {
      console.error('User not found with ID:', userId);
      return null;
    }

    const cloudinaryResponse = await cloudinary.uploader.upload(
      `uploads/profile/${userImage.filename}`,
      { folder: 'profile' }
    );

    user.userImage = cloudinaryResponse.secure_url;
    await user.save();
    console.log('UserImage updated successfully.');

    console.log('Before updating filename:', user.filename);

    user.filename.public_id = cloudinaryResponse.public_id;
    user.filename.url = cloudinaryResponse.secure_url;

    console.log('After updating filename:', user.filename);

    await user.save();
    console.log('UserImage and filename updated successfully.');

    return user;
  } catch (error) {
    console.error('Error in updateUserImage:', error);
    throw error;
  }
}
}
module.exports = UserService;
