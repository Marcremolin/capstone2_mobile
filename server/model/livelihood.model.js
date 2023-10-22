const db = require("../config/db");
const mongoose = require('mongoose');
const { Schema } = mongoose;

const livelihoodSchema = new Schema({
  what: String,
  where: String,
  when: String,
  who: String,
  filename: String,
});

const livelihood = db.model('livelihood', livelihoodSchema);

module.exports = livelihood;
