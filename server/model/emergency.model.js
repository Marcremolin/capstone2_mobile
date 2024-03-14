const db = require("../config/db");
const mongoose = require('mongoose');
const { Schema } = mongoose;
const emergencySchema = new Schema({
  userId: { type: String, required: true },
  residentName: { type: String, required: true },
  currentLocation: { type: String, required: true },
  phoneNumber: { type: String, required: true, index: true },
  emergencyType: { type: String, required: true, index: true },
  date: { type: Date, required: true, index: true },
  status: { type: String },
  emergencyProofImage: {
    public_id: { type: String },
    url: { type: String },
  }
});


const EmergencyModel = db.model('emergency', emergencySchema); 
module.exports = EmergencyModel;