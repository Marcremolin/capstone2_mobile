
const router = require('express').Router(); 
const FeedbackController = require("../controller/feedback.controller")
router.post('/feedback',FeedbackController.createFeedback);
//the API is requestDocument and whenever the API hit, we need to send the data to the CONTROLLER

module.exports = router;