//FETCH THE DATA that is request and respond from the user (frontend)
const UserService = require("../services/user.services");
//handle the request & respond from FrontEnd
const nodemailer = require('nodemailer'); 
const Mailgen = require('mailgen'); 
const UserModel = require("../model/user.model");
const config = require('../config/config');
const jwt = require('jsonwebtoken');
exports.register = async (req, res, next) => {
  try {
    let userImage;

    if (req.file) {
      userImage = req.file;
    }

    const {
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
    } = req.body; // Get the data from frontend

    if (userImage) {
      const successRes = await UserService.registerUser(
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
      );

      // RESPONSE BACK to frontend after successful registration from the user
      res.json({ status: true, success: "USER REGISTERED SUCCESSFULLYYY!!" });
    } else {
      res.json({ status: false, error: "User image not provided." });
    }
  } catch (error) {
    throw error;
  }
}
exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        const user = await UserService.checkuser(email);
        if (!user) {
            return res.status(401).json({ error: 'User does not exist' });
        }
        console.log('User found:', user);

        const isMatch = await user.comparePassword(password);
        
        console.log('Password match:', isMatch);
        console.log('Testing Secret Key:', config.secretKey)

        if (!isMatch) {
            return res.status(401).json({ error: 'Invalid password' });
        }

        // Creating Token
        let tokenData = {
           _id: user._id, 
           email: user.email, 
          lastName: user.lastName,
          firstName: user.firstName,
          middleName: user.middleName,
          suffix: user.suffix,
          houseNumber: user.houseNumber,
          barangay: user.barangay,
          cityMunicipality: user.cityMunicipality,
          district: user.district,
          province: user.province,
          region: user.region,
          phoneNumber: user.phoneNumber,
          nationality: user.nationality,
          civilStatus: user.civilStatus,
          highestEducation: user.highestEducation,
          employmentStatus: user.employmentStatus,
          homeOwnership: user.homeOwnership,
          residentClass: user.residentClass,
          birthPlace: user.birthPlace,
          age: user.age,
          dateOfBirth: user.dateOfBirth,
          sex: user.sex,
          companyName: user.companyName,
          position: user.position,
          votersRegistration: user.votersRegistration,
          filename: user.filename, 
          status: user.status};

          
        const token = await UserService.generateToken(tokenData, config.secretKey, "1D");
        const decoded = jwt.verify(token, config.secretKey);
        console.log('Verified Token:', decoded);
        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.error('Error in login:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}


exports.forgotpass = async (req, res) => {
  const BRGYEMAIL = 'dbarangayapplication@gmail.com';
  const PASSWORD = 'rrxc souh lvrv ybgm';

  try {
    const { email } = req.body;
    const config = {
      service: 'gmail',
      auth: {
        user: BRGYEMAIL,
        pass: PASSWORD,
      },
    };

    const transporter = nodemailer.createTransport(config);
    // Generate a random 6-digit verification code
    const verificationCode = Math.floor(100000 + Math.random() * 900000);

    const user = await UserModel.findOne({ email });

    if (!user) {
      return res.status(400).json({ error: 'User not found' });
    }

    user.verificationCode = verificationCode;
    user.verificationCodeUsed = false;

    await user.save();

    const MailGenerator = new Mailgen({
      theme: 'default',
      product: {
        name: "Mailgen",
        link: 'https://mailgen.js/'
      }
    });

    const passresetmail = {
      body: {
        name: 'Human Being',
        intro: 'This email contains a 6-digit verification code to reset the password of your DBarangay account.',
        action: {
          instructions: 'Your verification code:',
          button: {
            color: '#4BA2FF',
            text: verificationCode.toString(), // Include the verification code
            link: '',
          }
        },
        outro: 'Be sure to always keep your verification code somewhere safe but accessible.',
        signature: false
      }
    };

    const mail = MailGenerator.generate(passresetmail);
    const message = {
      from: BRGYEMAIL,
      to: email,
      subject: "D'Barangay Password Reset Verification Code",
      html: mail,
    };

    // Send the email with the verification code
    transporter.sendMail(message).then(() => {
      return res.status(201).json({
        msg: "You received an email with the verification code"
      });
    });
  } catch (error) {
    console.error('Error sending email:', error);
    res.status(500).json({ error });
  }
};

//------------------- VERIFY  Verification Code ------------- ------------
exports.verifyAndResetPassword = async (req, res) => {
  const { email, verificationCode, newPassword } = req.body;
  console.log('Received data from the frontend:');
  console.log('Email:', email);
  console.log('Verification Code:', verificationCode);
  console.log('New Password:', newPassword);

  const user = await UserModel.findOne({ email });

  if (!user) {
    return res.status(400).json({ error: 'User not found' });
  }

  console.log('Stored Verification Code (from email):', user.verificationCode);

  // Check if the verificationCode matches the one you sent in the email
  if (verificationCode !== user.verificationCode) {
    return res.status(400).json({ error: 'Invalid verification code' });
  }

  if (user.verificationCodeUsed) {
    return res.status(400).json({ error: 'Verification code has already been used' });
  }

  // Update the user's password with the new password
  user.password = newPassword;
  user.verificationCodeUsed = true;

  await user.save();
  res.status(200).json({ message: 'Password reset successfully' });
};















exports.updateProfile= async (req, res, next) => {
  try {
      const { userId } = req.body; // Assuming you have a way to identify the user
      let userImage;

      if (req.file) {
          userImage = req.file;
      }

      await UserService.updateProfileImage(userId, userImage);

      res.json({ status: true, success: "User profile image updated successfully" });
  } catch (error) {
      console.error('Error in updating user profile image:', error);
      res.status(500).json({ error: 'Internal server error' });
  }
};
