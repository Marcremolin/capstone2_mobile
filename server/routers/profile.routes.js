const express = require('express');
const router = express.Router();
const ProfileController = require('../controller/profile.controller');
const authenticate = require('./verifyToken');

// Define a route to get a user's profile
router.get('/profile', authenticate, ProfileController.getUserProfile);

module.exports = router;



// const router = require('express').Router(); 
// const ProfileController = require("../controller/profile.controller");
// const authenticate = require('./verifyToken'); 




// // router.get('/profile', authenticate, UserController.getUserProfile);
// // Add a new route to get a user's profile by ID
// router.get('/profile/:userId', authenticate, ProfileController );

// module.exports = router;