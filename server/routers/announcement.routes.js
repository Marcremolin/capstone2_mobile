const express = require('express');
const router = express.Router();
const AnnouncementController = require('../controller/announcement.controller');

router.get('/announcements', AnnouncementController.getAllAnnouncements);

module.exports = router;
