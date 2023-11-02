// models/Announcement.js
const db = require("../config/db");
const mongoose = require('mongoose');
const { Schema } = mongoose;

const announcementSchema = new Schema({
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
    }
  },
});

const announcement = db.model('announcement', announcementSchema);

module.exports = announcement;
