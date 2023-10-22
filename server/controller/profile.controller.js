const ProfileService = require("../services/profile.services");

// Function to get a user's profile by ID
exports.getUserProfile = async (req, res) => {
    try {
      const userId = req.user.id; // Extract user ID from the token
      const user = await ProfileService.getUserById(userId);
      
      if (!userProfile) {
        return res.status(404).json({ message: 'User not found' });
      }
      return res.status(200).json(user);
    } catch (error) {
        res.status(500).json({ error: 'Internal server error' });
      }
    };


    
















    
//     try {
//       const { userId } = req.params;
//       const token = req.header('Authorization');
//       console.log('Token in Profile Route:', token);

//       if (!userId) {
//         return res.status(400).json({ message: 'User ID is missing in the request params' });
//       }

//       const user = await ProfileService.getUserProfile(userId);

//       if (!user) {
//         return res.status(404).json({ message: 'User not found' });
//       }

//       res.status(200).json(user);
//     } catch (error) {
//       console.error('Error in getUserProfile:', error);
//       res.status(500).json({ message: 'Server error' });
//     }
// };

  //-----------------------------------------------------------------------------
  // exports.getUserProfile = async (req, res) => {
  //   try {
  //     // Extract the user's ID from the token
  //     const userIdFromToken = req.user._id; // Check how the token is stored in the request
  
  //     // Debugging output
  //     console.log('User ID from Token:', userIdFromToken);
  
  //     // Get the user's profile from the database
  //     const user = await UserModel.findById(userIdFromToken); // Verify that the user's ID from the token is being used
  
  //     if (!user) {
  //       return res.status(404).json({ message: 'User not found' });
  //     }
  
  //     // Debugging output
  //     console.log('User ID from Database:', user._id);
  
  //     res.status(200).json(user);
  //   } catch (error) {
  //     res.status(500).json({ message: 'Server error' });
  //   }
  // };
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // exports.getUserProfile = async (req, res) => {
  //   try {
  //     // req.user._id should contain the user's ID if you've successfully verified the token
  //     const user = await UserService.getUserProfile(req.user._id);
  
  //     if (!user) {
  //       return res.status(404).json({ message: 'User not found' });
  //     }
  
  //     res.status(200).json(user);
  //   } catch (error) {
  //     res.status(500).json({ message: 'Server error' });
  //   }
  // };
  
  
  
  