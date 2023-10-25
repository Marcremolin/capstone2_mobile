const db = require("../config/db");
const mongoose = require('mongoose');
const UserModel = require('../model/user.model') //Needed this to refer to users data
const { Schema } = mongoose;
//----------------------------------- important imports ---------------------------------------

const feedbackSchema = new Schema({

  userId: { type: String, required: true },

  date:{
    type: Date,
    required: true,
    index: true,
},

  feedback:{
    type: String,
    required: true,
    index: true,
  },

});

const FeedbackModel = db.model('feedback', feedbackSchema); 
module.exports = FeedbackModel;

//'feedback' is the database collection name 