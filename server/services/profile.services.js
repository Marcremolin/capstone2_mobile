const UserModel = require('../model/user.model')

class UserProfile {
  static async getUserProfile(userId) {
    try {
      const user = await UserModel.findById(userId);
      if (!user) {
      }
      return user;
    } catch (error) {
      console.error('Error fetching user profile:', error); 
      throw new Error('Error fetching user profile');
    }
  }
  static async updateProfilePicture(userId, newProfilePicture) {
    try {
      const user = await UserModel.findById(userId);
      if (!user) {
        console.error('User not found for _id:', userId);
        return null;
      }

      // Debugging: Log the newProfilePicture before updating
      console.log('Updating profile picture with:', newProfilePicture);

      user.userImage = newProfilePicture;
      const updatedUser = await user.save();

      // Debugging: Log the updatedUser after the update
      console.log('Updated user:', updatedUser);

      return updatedUser;
    } catch (error) {
      console.error('Error updating profile picture:', error);
      throw new Error('Error updating profile picture');
    }
  }
}






module.exports = UserProfile;






