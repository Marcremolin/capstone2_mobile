const db = require("../config/db");
const mongoose = require('mongoose');
const UserModel = require('../model/user.model') //Needed this to refer to users data
const { Schema } = mongoose;
//----------------------------------- important imports ---------------------------------------

// BARANGAY INDIGENCY --------------------
const barangayIndigencySchema = new Schema({
  userId: { type: String, required: true },
  // userId: {type: Schema.Types.ObjectId, ref:UserModel.modelName}, //by making use of UserID we can show the data or the list of request in the flutter app
  userAddress:{type: String, required: true},
  typeOfDocument:{type: String,required: true,index: true}, // used to optimize the retrieval of data and improve the performance of queries kasi NAGBUBUFFER SHIT
  dateOfPickUp:{type: Date, required: true, index: true},
  reasonForRequesting:{type: String, required: true, index: true}, 
  paymentMethod:{type: String, required: true, index: true},
  paymentReferenceNumber:{type: String,required: false },
  status: {type: String}
});

const userIndigency = db.model('BarangayIndigency', barangayIndigencySchema); 

// BARANGAY CERTIFICATE --------------------
const barangayCertifcateSchema = new Schema({
  userId: { type: String, required: true },
  userAddress:{type: String,required: true},
  typeOfDocument:{type: String,required: true,index: true},
  dateOfPickUp:{type: Date,required: true, index: true},
  reasonForRequesting:{type: String,required: true, index: true},
  paymentMethod:{type: String, required: true, index: true},
  paymentReferenceNumber:{type: String,required: false},
  status: {type: String}
});

const userCertificate = db.model('barangaycertificate', barangayCertifcateSchema); 

// BUSINESS CLEARANCE --------------------
const businessClearanceSchema = new Schema({
  userId: { type: String, required: true },
  businessName:{type: String, required: true},
  businessAddress:{type: String, required: true},
  typeOfDocument:{type: String, required: true, index: true},
  dateOfPickUp:{type: Date, required: true, index: true},
  reasonForRequesting:{type: String, required: true, index: true},
  paymentMethod:{type: String, required: true, index: true},
  paymentReferenceNumber:{type: String, required: false},
  status: {type: String}
 
});

const userBusinessClearance = db.model('BusinessClearance', businessClearanceSchema); 


// BARANGAY ID --------------------
const BarangayIDSchema = new Schema({
  userId: { type: String, required: true },
  typeOfDocument:{type: String, required: true, index: true},
  dateOfPickUp:{type: Date, required: true, index: true,},
  reasonForRequesting:{type: String, required: true, index: true,},
  paymentMethod:{type: String, required: true, index: true},
  paymentReferenceNumber:{type: String, required: false,},
  status: {type: String }
});

const userBarangayID = db.model('barangayid', BarangayIDSchema); 


// INSTALLATION PERMIT--------------------
const installationSchema = new Schema({
  userId: { type: String, required: true },
  typeOfDocument:{type: String, required: true, index: true},
  dateOfPickUp:{type: Date, required: true, index: true,},
  reasonForRequesting:{type: String, required: true, index: true,},
  paymentMethod:{type: String, required: true, index: true},
  paymentReferenceNumber:{type: String, required: false,},
  status: {type: String }
});

const userInstallation = db.model('Installation', installationSchema); 


// CONSTRUCTION PERMIT--------------------
const constructionSchema = new Schema({
  userId: { type: String, required: true },
  typeOfDocument:{type: String, required: true, index: true},
  dateOfPickUp:{type: Date, required: true, index: true,},
  reasonForRequesting:{type: String, required: true, index: true,},
  paymentMethod:{type: String, required: true, index: true},
  paymentReferenceNumber:{type: String, required: false,},
  status: {type: String }
});

const userConstruction = db.model('Construction', constructionSchema); 


//---------------- MODULE EXPORTS ------------------------

  
  module.exports = {
    userIndigency,
    userCertificate,
    userBusinessClearance,
    userBarangayID,
    userInstallation,
    userConstruction,
  };




