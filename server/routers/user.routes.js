const router = require('express').Router();
const multer = require('multer');
const UserController = require('../controller/user.controller');
const authenticate = require('./verifyToken');

const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, 'uploads/profile'); 
  },
  filename: function (req, file, cb) {
    cb(null, Date.now() + '-' + file.originalname); 
  },
});
const upload = multer({ storage: storage });

router.post('/registration', upload.single('userImage'), UserController.register);
router.post('/login', UserController.login);
router.post('/forgetpass', UserController.forgotpass);
router.post('/verifyAndResetPassword', UserController.verifyAndResetPassword);
router.put('/updateUserImage', authenticate, upload.single('userImage'), UserController.updateUserImage);

module.exports = router;









