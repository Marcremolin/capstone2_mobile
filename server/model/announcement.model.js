// models/Announcement.js
const db = require("../config/db");
const mongoose = require('mongoose');
const { Schema } = mongoose;

const announcementSchema = new Schema({
  what: String,
  where: String,
  when: String,
  who: String,
  filename: String,

});

const announcement = db.model('announcement', announcementSchema);

module.exports = announcement;
