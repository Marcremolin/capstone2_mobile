const ProfileService = require("../services/profile.services");

// Function to get a user's profile by ID
exports.getUserProfile = async (req, res) => {
    try {
      const userId = req.user._id;  

      console.log('User ID from JWT token:', userId); 
      const user = await ProfileService.getUserProfile(userId); 

      if (!user) {
          console.error('User not found for _id:', userId);
          return res.status(404).json({ message: 'User not found' });
      }
          console.log('User data retrieved:', user); 
          return res.status(200).json(user);


        } catch (error) {
          console.error(error);

      res.status(500).json({ error: error.message }); 
    }
    };


    










