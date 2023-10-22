//FETCH THE DATA that is request and respond from the user (frontend)

const UserService = require("../services/user.services");
const UserModel = require('../model/user.model');

//handle the request & respond from FrontEnd

exports.register = async (req, res, next) => {
    try { //pass the data from the services 
        console.log("---req body---", req.body);
        const { lastName,
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
        votersRegistration } = req.body; //Get the data from frontend 

        const successRes = await UserService.registerUser(
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
            residentClass,votersRegistration);

        //RESPONSE BACK to frontend after successfully registration from user 
        res.json({status:true,success:"USER REGISTERED SUCCESSFULLYYY!!"})
} catch (error){
    throw error
}

}


exports.login = async (req, res, next) => {
    try {
        const { emailAddress, password } = req.body;
        console.log('Password entered during login:', password); // Log the entered password

        const user = await UserService.checkuser(emailAddress);
        if (!user) {
          throw new Error('User does not exist'); 
        }
        console.log('User found:', user);
        console.log('Retrieved Hashed Password:', user.password);

        const isMatch = await user.comparePassword(password); 
        console.log('Password match:', isMatch);    
        if (isMatch === false) {       
            throw new Error('PASSWORD INVALID!'); 
        }
        // Creating Token
        let tokenData = { _id: user._id, emailAddress: user.emailAddress };
        const token = await UserService.generateToken(tokenData, "secret", "1h");

        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
    
    }
}
