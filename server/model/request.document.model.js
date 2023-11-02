const db = require("../config/db");
const mongoose = require('mongoose');
const { Schema } = mongoose;
//----------------------------------- important imports ---------------------------------------

// BARANGAY INDIGENCY --------------------
const barangayIndigencySchema = new Schema({
  residentName: {type: String,required: true},
  userId: {type: String, required: true},
  address: {type: String, required: true},
  typeOfDocument:{type: String,required: true,index: true}, // used to optimize the retrieval of data and improve the performance of queries kasi NAGBUBUFFER SHIT
  reasonOfRequest: {type: String, required: true},
  pickUpDate: {type: String, required: true },
  modeOfPayment: {type: String, required: true},
  reference: {type: String},
  status: {type: String, default: 'New' },
});

const userIndigency = db.model('BarangayIndigency', barangayIndigencySchema); 

// BARANGAY CERTIFICATE --------------------
const barangayCertifcateSchema = new Schema({
  typeOfDocument:{type: String,required: true,index: true}, // used to optimize the retrieval of data and improve the performance of queries kasi NAGBUBUFFER SHIT

  residentName: {type: String,required: true},
  userId: {type: String, required: true},
  address: {type: String, required: true},
  reasonOfRequest: {type: String, required: true},
  pickUpDate: {type: String, required: true },
  modeOfPayment: {type: String, required: true},
  reference: {type: String},
  status: {type: String, default: 'New' },
});

const userCertificate = db.model('barangaycertificate', barangayCertifcateSchema); 

// BUSINESS CLEARANCE --------------------
const businessClearanceSchema = new Schema({
  typeOfDocument:{type: String,required: true,index: true}, // used to optimize the retrieval of data and improve the performance of queries kasi NAGBUBUFFER SHIT

  businessName:{
    type:String,
},
address:{
    type:String,
    required:true
},
residentName:{
  type:String,
  required:true
},
userId: {
  type: String,
  required: true
},
type:{
  type:String,
  required:true
},
reasonOfRequest:{
    type:String,
    required:true
},
pickUpDate:{
    type:String,
    required:true
},
modeOfPayment:{
  type:String,
  required:true
},
reference:{
  type:String
},
status:{
  type:String,
  default:'New'
}
 
});

const userBusinessClearance = db.model('BusinessClearance', businessClearanceSchema); 


// BARANGAY ID --------------------
const BarangayIDSchema = new Schema({
  typeOfDocument:{type: String,required: true,index: true}, // used to optimize the retrieval of data and improve the performance of queries kasi NAGBUBUFFER SHIT

  residentName: {type: String,required: true},
  userId: {type: String, required: true},
  address: {type: String, required: true},
  reasonOfRequest: {type: String, required: true},
  pickUpDate: {type: String, required: true },
  modeOfPayment: {type: String, required: true},
  reference: {type: String},
  status: {type: String, default: 'New' },
});

const userBarangayID = db.model('barangayid', BarangayIDSchema); 


// INSTALLATION PERMIT--------------------
const installationSchema = new Schema({
  typeOfDocument:{type: String,required: true,index: true}, // used to optimize the retrieval of data and improve the performance of queries kasi NAGBUBUFFER SHIT

  residentName: {type: String,required: true},
  userId: {type: String, required: true},
  address: {type: String, required: true},
  reasonOfRequest: {type: String, required: true},
  pickUpDate: {type: String, required: true },
  modeOfPayment: {type: String, required: true},
  reference: {type: String},
  status: {type: String, default: 'New' },
});

const userInstallation = db.model('Installation', installationSchema); 


// CONSTRUCTION PERMIT--------------------
const constructionSchema = new Schema({
  typeOfDocument:{type: String,required: true,index: true}, // used to optimize the retrieval of data and improve the performance of queries kasi NAGBUBUFFER SHIT

  residentName: {type: String,required: true},
  userId: {type: String, required: true},
  address: {type: String, required: true},
  reasonOfRequest: {type: String, required: true},
  pickUpDate: {type: String, required: true },
  modeOfPayment: {type: String, required: true},
  reference: {type: String},
  status: {type: String, default: 'New' },
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




