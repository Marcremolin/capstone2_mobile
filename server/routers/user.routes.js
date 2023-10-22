const router = require('express').Router(); 
const UserController = require("../controller/user.controller");
// const authenticate = require('./verifyToken'); 



router.post('/registration',UserController.register);
router.post('/login',UserController.login);
// router.get('/profile', authenticate, UserController.getUserProfile);
// Add a new route to get a user's profile by ID
// router.get('/profile/:userId', authenticate, UserController.getUserProfileById);

module.exports = router;