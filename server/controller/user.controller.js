//FETCH THE DATA that is request and respond from the user (frontend)
const UserService = require("../services/user.services");
//handle the request & respond from FrontEnd
const nodemailer = require('nodemailer'); // Used for sending email
const jwt = require('jsonwebtoken'); // Used for creating JSON Web Tokens
const Mailgen = require('mailgen'); // Used for generating HTML email content
const crypto = require('crypto');
const UserModel = require("../model/user.model");

exports.register = async (req, res, next) => {
    try { //pass the data from the services 
        console.log("---req body---", req.body);
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
            type} = req.body; //Get the data from frontend 


        const successRes = await UserService.registerUser( 
            //28 data from user 
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
            type);

        //RESPONSE BACK to frontend after successfully registration from user 
        res.json({status:true,success:"USER REGISTERED SUCCESSFULLYYY!!"})
} catch (error){
    throw error
}

}

exports.login = async (req, res, next) => {
    try {
        const { email, password } = req.body;
        console.log('Password entered during login:', password); // Log the entered password

        const user = await UserService.checkuser(email);
        if (!user) {
            return res.status(401).json({ error: 'User does not exist' });
        }
        console.log('User found:', user);
        console.log('Retrieved Hashed Password:', user.password);

        const isMatch = await user.comparePassword(password);
        
        console.log('Password match:', isMatch);
        if (!isMatch) {
            return res.status(401).json({ error: 'Invalid password' });
        }

        // Creating Token
        let tokenData = { _id: user._id, email: user.email };
        const token = await UserService.generateToken(tokenData, "secret", "1h");

        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.error('Error in login:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
}


//------------------------ SHITS -------------------------------------
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

    // Save the verification code in the user object and reset the usage flag
    user.verificationCode = verificationCode;
    user.verificationCodeUsed = false;

    // Save the user with the verification code to the database
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
























