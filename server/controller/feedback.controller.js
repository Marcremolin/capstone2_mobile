//----- FETCH THE DATA THAT IS REQUEST AND RESPONSE BY THE USER SENT FROM THE FLUTTER ---------------------

const Feedback = require("../services/feedback.services")
//important imports--------------------------------------------------

exports.createFeedback = async (req, res, next) => {
  try {
    console.log('Request Body:', req.body); 

    const{
    userId,
    date,
    feedback
  } = req.body; //Accept parameteres from FRONTEND in a JSON Format


    let feedbackReq = await Feedback.createFeedback(
      userId,
      date,
      feedback) //TO SEND TO SERVICES
    
      res.json({status:true,success:feedbackReq}) 

  }
  catch(error){
    next(error);

  }
}



































