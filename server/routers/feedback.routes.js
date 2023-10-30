
const router = require('express').Router(); 
const FeedbackController = require("../controller/feedback.controller")
router.post('/feedback',FeedbackController.createFeedback);

module.exports = router;