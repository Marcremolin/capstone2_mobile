const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors'); 
const userRouter = require('./routers/user.routes');
const requestDocumentRouter = require('./routers/request.document.routes');
const feedbackRouter = require('./routers/feedback.routes');
const emergencyRouter = require('./routers/emergency.routes');
const announcementRouter = require('./routers/announcement.routes');
const livelihoodRouter = require('./routers/livelihood.routes');
const promoteBusinessRouter = require('./routers/promoteBusiness.routes');
const profileRouter = require('./routers/profile.routes');
const app = express();
const path = require('path');
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, '../views'));
app.use(express.urlencoded({ extended: false }));
app.use(express.json());
const multer = require('multer');

app.use(bodyParser.json());
app.use(cors());

// Routes for various features
app.use('/', userRouter);  
app.use('/', requestDocumentRouter); 
app.use('/', feedbackRouter); 
app.use('/', emergencyRouter);
app.use('/get', announcementRouter); 
app.use('/get', livelihoodRouter); 
app.use('/get', promoteBusinessRouter); 
app.use('/profile', profileRouter); 
app.use('/uploads', express.static('uploads'));

module.exports = app;
