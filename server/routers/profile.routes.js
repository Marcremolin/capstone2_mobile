const express = require('express');
const router = express.Router();
const ProfileController = require('../controller/profile.controller');
const authenticate = require('./verifyToken');
const multer = require('multer');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/profile');
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + '-' + file.originalname);
  },
});
const upload = multer({ storage: storage });

router.get('/user', authenticate, (req, res) => {
  console.log('User information extracted from token:', req.user); 
  ProfileController.getUserProfile(req, res);
});

router.put('/user/profile-picture', authenticate, upload.single('userImage'), ProfileController.updateProfilePicture);

module.exports = router;
