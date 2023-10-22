const UserModel = require('../model/user.model')

class UserProfile {
  static async getUserProfile(userId) {
    try {
      const user = await UserModel.findById(userId);
      return user;
    } catch (error) {
      throw new Error('Error fetching user profile');
    }
  }
}

module.exports = UserProfile;











  
// exports.getUserById = async (userId) => {
//     try {
//       const collection = db.getDb().collection('users');
//       const user = await collection.findOne({ _id: ObjectId(userId) });
//       return user;
//     } catch (error) {
//       throw error;
//     }
//   };
// class ProfileService {
//   static async getUserProfile(userId) {
//     try {
//       const user = await UserModel.findById(userId);
//       if (!user) {
//         throw new Error('User not found');
//       }
//       return user;
//     } catch (error) {
//       throw error;
//     }
//   }

// }
//   module.exports = ProfileService;


      // //Retrieving the user's profile based on the provided userId. This function seems to be designed for this purpose
//   static async getUserProfile(userId) {
//     try {
//       const user = await UserModel.findById(userId);
//       if (!user) {
//         throw new Error('User not found');
//       }
//       return user;
//     } catch (error) {
//       throw error;
//     }
//   }
  
  // Function to retrieve a user's profile by ID