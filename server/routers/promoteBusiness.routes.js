// routes/announcementRoutes.js
const express = require('express');
const router = express.Router();
const promoteBusinessController = require('../controller/promoteBusiness.controller');

router.get('/promoteBusiness', promoteBusinessController.getAllBusinessPromotion);

module.exports = router;
