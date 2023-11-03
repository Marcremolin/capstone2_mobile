const db = require("../config/db");
const mongoose = require('mongoose');
const { Schema } = mongoose;

const livelihoodSchema = new Schema({
  what: String,
  where: String,
  when: String,
  who: String,
  filename: { //TO CATCH IMAGE
    public_id: {
      type: String,
      required: true
    },
    url: {
      type: String,
      required: true
    }}});

const livelihood = db.model('livelihood', livelihoodSchema);

module.exports = livelihood;
