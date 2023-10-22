// routes/announcementRoutes.js
const express = require('express');
const router = express.Router();
const LivelihoodController = require('../controller/livelihood.controller');

router.get('/livelihood', LivelihoodController.getAllLivelihood);

module.exports = router;
