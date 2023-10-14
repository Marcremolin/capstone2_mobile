// ------------------------- STORE THE DATA ENTERED BY A USER TO THE DATABASE -------------------------

const FeedbackModel = require('../model/feedback.model');

class feedbackReq {
  static async createFeedback ( 
  userID,
  date,
  feedback)
    
    { 
      const createFeedback = new FeedbackModel({ 
        userID,
        date,
        feedback}); 

        return await createFeedback.save(); 
    }
}
  module.exports = feedbackReq;


















