const AnnouncementService = require('../services/announcement.service');
class AnnouncementController {
  async getAllAnnouncements(req, res) {
    try {
      const announcements = await AnnouncementService.getAllAnnouncements();
      res.json(announcements);
    } catch (error) {
      res.status(500).json({ error: 'Internal Server Error' });
    }
  }
}

module.exports = new AnnouncementController();






























