const express = require('express');
const router = express.Router();
const ProfileController = require('../controller/profile.controller');
const authenticate = require('./verifyToken');


router.get('/user', authenticate, (req, res) => {
  console.log('User information extracted from token:', req.user); 
  ProfileController.getUserProfile(req, res);
});
router.put('/user/profile-picture', authenticate, ProfileController.updateProfilePicture);
// router.put('/user/profile-picture', authenticate, ProfileController.updateProfilePicture);

module.exports = router;






