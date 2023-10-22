const bcrypt = require('bcrypt');
const UserModel = require('../model/user.model');

async function updatePassword(req, res) {
  const { emailAddress } = req.params; // Get the email address from the URL parameters
  const { newPassword } = req.body; // Get the new password from the request body

  try {
    if (!newPassword) {
      return res.status(400).json({ error: 'New password is missing' });
    }

    const user = await UserModel.findOne({ emailAddress });

    if (!user) {
      return res.status(404).json({ error: 'User not found' });
    }

      console.log('Updating password for user:');
    console.log('User ID:', user._id);
    console.log('Email Address:', emailAddress);
    console.log('Previous Password:', user.password);
    // Update only the password field
    const salt = await bcrypt.genSalt(10);
    user.password = await bcrypt.hash(newPassword, salt);

    await user.save();

    return res.json({ message: 'Password updated successfully' });
  } catch (error) {
    console.error(error);
    return res.status(500).json({ error: 'Internal server error' });
  }
}

module.exports = {
  updatePassword,
};
