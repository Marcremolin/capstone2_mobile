const promoteBusinessService = require('../services/promoteBusiness.services.js');
class PromoteBusinessController {
  async getAllBusinessPromotion(req, res) {
    try {
      const promotebusiness = await promoteBusinessService.getAllBusinessPromotion();
      res.json(promotebusiness);
    } catch (error) {
      res.status(500).json({ error: 'Internal Server Error' });
    }
  }
}

module.exports = new PromoteBusinessController();
