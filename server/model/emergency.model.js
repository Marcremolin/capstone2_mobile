const db = require("../config/db");
const mongoose = require('mongoose');
const { Schema } = mongoose;
//----------------------------------- important imports ---------------------------------------

const emergencySchema = new Schema({
  userId: { type: String, required: true },
  currentLocation: {type: String,required: true},
  phoneNumber: {type: String},
  emergencyType:{type: String,required: true,index: true},
  date:{type: Date,required: true,index: true},
  status: {type: String}

});

const EmergencyModel = db.model('emergency', emergencySchema); 
module.exports = EmergencyModel;

