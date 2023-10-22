const LivelihoodService = require('../services/livelihood.services');
class LivelihoodController {
  async getAllLivelihood(req, res) {
    try {
      const livelihood = await LivelihoodService.getAllLivelihood();
      res.json(livelihood);
    } catch (error) {
      res.status(500).json({ error: 'Internal Server Error' });
    }
  }
}

module.exports = new LivelihoodController();
