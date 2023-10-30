const express = require('express');
const router = express.Router();
const ProfileController = require('../controller/profile.controller');
const authenticate = require('./verifyToken');


router.get('/user', authenticate, (req, res) => {
  console.log('User information extracted from token:', req.user); 
  ProfileController.getUserProfile(req, res);
});

module.exports = router;






