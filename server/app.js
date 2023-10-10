const express = require('express'); 
const body_parser = require('body-parser'); //Check whatever data comes with the request body
const userRouter = require('./routers/user.routes');
const app = express();



app.use(body_parser.json());
app.use('/',userRouter);
module.exports = app; 
