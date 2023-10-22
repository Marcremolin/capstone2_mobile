const express = require('express');
const router = express.Router();
const forgetPasswordController = require('../controller/forgetPassword.controller');

router.put('/update-password/:emailAddress', forgetPasswordController.updatePassword);

module.exports = router;