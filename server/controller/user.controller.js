const UserService = require("../services/user.services");

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
            pensioner,
            password,
            dateOfBirth,
            gender,
            homeOwnership,
            residentClass } = req.body; //Get the data from frontend 

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
            pensioner,
            password,
            dateOfBirth,
            gender,
            homeOwnership,
            residentClass);

        //RESPONSE BACK to frontend after successfully registration from user 
        res.json({ status: true, success: "User Registered Successfully." })
    } catch (error) {
        throw error
    }

}


exports.login = async (req, res, next) => {
    try {
        const { emailAddress, password } = req.body;
        if (!email || !password) {
            throw new Error('Parameter are not correct');
        }

        let user = await UserService.checkuser(emailAddress);
        if (!user) {
            throw new Error('User does not exist');
        }
        console.log('User found:', user);

        const isMatch = await user.comparePassword(password);

        console.log('Password match:', isMatch);
        if (isMatch === false) {
            throw new Error('Username or Password does not match.');
        }
        // Creating Token
        const tokenData = { _id: user._id, emailAddress: user.emailAddress };
        const token = await UserService.generateToken(tokenData, "secret", '1h');

        res.status(200).json({ status: true, success: "sendData", token: token });
    } catch (error) {
        console.log(error, 'err---->');
        next(error);
    }
}
