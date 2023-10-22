const businessPromotion = require('../model/promoteBusiness.model');

class promoteBusinessService {
  async getAllBusinessPromotion() {
    try {
      const promoteBusiness = await businessPromotion.find();
      return promoteBusiness;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = new promoteBusinessService();
