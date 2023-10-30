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
}

module.exports = UserProfile;






