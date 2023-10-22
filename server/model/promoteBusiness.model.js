const db = require("../config/db");
const mongoose = require('mongoose');
const { Schema } = mongoose;


const promoteBusinessSchema = new Schema({
  businessName: String,
  address: String,
  hours: String,
  category: String,
  contact: String,
  residentName: String,
  filename: String,
});

const promoteBusiness = db.model('promoteBusiness', promoteBusinessSchema);

module.exports = promoteBusiness;
