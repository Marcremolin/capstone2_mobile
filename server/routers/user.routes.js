const router = require('express').Router(); 
const UserController = require("../controller/user.controller");
router.post('/registration',UserController.register);
router.post('/login',UserController.login);
router.post('/forgetpass',UserController.forgotpass);
router.post('/verifyAndResetPassword',UserController.verifyAndResetPassword);

module.exports = router;