
const bcrypt = require('bcrypt');
const UserModel = require('../model/user.model');

async function updatePassword(emailAddress, newPassword) {
  try {
    const user = await UserModel.findOne({ emailAddress });

    if (!user) {
      return null;
    }

    // Update only the password field
    const salt = await bcrypt.genSalt(10);
    const newHashedPassword = await bcrypt.hash(newPassword, salt);

    console.log('Hashed Password (new):', newHashedPassword);
    user.password = newHashedPassword;

    await user.save();
    console.log('Password updated successfully');
    return res.json({ message: 'Password updated successfully' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}