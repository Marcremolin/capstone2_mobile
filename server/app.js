const express = require('express');
const bodyParser = require('body-parser');
const userRouter = require('./routers/user.routes');
const requestDocumentRouter = require('./routers/request.document.routes');
const feedbackRouter = require('./routers/feedback.routes');
const emergencyRouter = require('./routers/emergency.routes');
const announcementRouter = require('./routers/announcement.routes');
const livelihoodRouter = require('./routers/livelihood.routes');
const promoteBusinessRouter = require('./routers/promoteBusiness.routes');
const profileRouter = require('./routers/profile.routes');
const forgetPasswordRouter = require('./routers/forgetPassword.routes');

const multer = require('multer');
const app = express();

app.use(bodyParser.json());

// Routes for various features
app.use('/', userRouter);  // User-related routes
app.use('/', requestDocumentRouter); // Request document-related routes
app.use('/', feedbackRouter); // Feedback-related routes
app.use('/', emergencyRouter); // Emergency-related routes

// Use '/get' prefix for these routes
app.use('/get', announcementRouter); // Announcement-related routes
app.use('/get', livelihoodRouter); // Livelihood-related routes
app.use('/get', promoteBusinessRouter); // Promote business-related routes

// Use '/profile' prefix for profile-related routes
app.use('/profile', profileRouter); // Profile-related routes
app.use('/forgetPassword', forgetPasswordRouter); 

// Serve static files from the 'uploads' directory
app.use('/uploads', express.static('uploads'));

module.exports = app;
