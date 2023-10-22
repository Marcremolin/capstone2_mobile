const livelihood = require('../model/livelihood.model');

class LivelihoodService {
  async getAllLivelihood() {
    try {
      const livelihoodData = await livelihood.find();
      return livelihoodData;
    } catch (error) {
      throw error;
    }
  }
}

module.exports = new LivelihoodService();
