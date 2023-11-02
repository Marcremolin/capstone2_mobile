// services/announcementService.js
const announcement = require('../model/announcement.model');
class AnnouncementService {
  async getAllAnnouncements() {
    try {
      const announcements = await announcement.find();
      return announcements;
    } catch (error) {
      throw error;
    }
  }
  }
  
  module.exports = new AnnouncementService();
