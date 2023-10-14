const db = require("../config/db");
const mongoose = require('mongoose');
const UserModel = require('../model/user.model') //Needed this to refer to users data
const { Schema } = mongoose;
//----------------------------------- important imports ---------------------------------------

const emergencySchema = new Schema({

  userId: {
    type: Schema.Types.ObjectId, 
    ref:UserModel.modelName
  }, 
  
  currentLocation:{
    type: String,
    required: true,
    index: true,
},

contactNum:{
    type: String,
    required: true,
    index: true, 
  },

  emergencyType:{
    type: String,
    required: true,
    index: true, 
  },

  date:{
    type: Date,
    required: true,
    index: true,
},

status: {
    type: String
}


});

const EmergencyModel = db.model('emergency', emergencySchema); 
module.exports = EmergencyModel;

