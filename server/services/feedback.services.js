// ------------------------- STORE THE DATA ENTERED BY A USER TO THE DATABASE -------------------------

const FeedbackModel = require('../model/feedback.model');

class feedbackReq {
  static async createFeedback ( 
      userId,
      date,
      feedback)
    
    { 
      const createFeedback = new FeedbackModel({ 
        userId,
        date,
        feedback}); 
        return await createFeedback.save(); 
    }
}
  module.exports = feedbackReq;


















