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


    exports.updateProfilePicture = async (req, res) => {
      try {
          const userId = req.user._id;
  
          // Assuming you receive the new profile picture information as part of the request
          const newProfilePicture = {
              public_id: 'new_public_id',
              url: 'new_image_url',     
          };
  
          const updatedUser = await ProfileService.updateProfilePicture(userId, newProfilePicture);
            if (updatedUser) {
              return res.status(200).json({ message: 'Profile picture updated successfully', user: updatedUser });
          } else {
              return res.status(500).json({ message: 'Failed to update profile picture' });
          }
      } catch (error) {
          console.error(error);
          res.status(500).json({ error: error.message });
      }
  };









