const db = require("../config/db");
const mongoose = require('mongoose');
const { Schema } = mongoose;
//----------------------------------- important imports ---------------------------------------

// BARANGAY INDIGENCY --------------------
const barangayIndigencySchema = new Schema({
  residentName: {type: String,required: true},
  userId: {type: String, required: true},
  address: {type: String, required: true},
  typeOfDocument:{type: String,required: true,index: true}, 
  reasonOfRequest: {type: String, required: true},
  pickUpDate: {type: String, required: true },
  modeOfPayment: {type: String, required: true},
  reference: {type: String},
  status: {type: String, default: 'New' },
});

const userIndigency = db.model('BarangayIndigency', barangayIndigencySchema); 

// BUSINESS CLEARANCE --------------------
const businessClearanceSchema = new Schema({
  typeOfDocument:{type: String}, // used to optimize the retrieval of data and improve the performance of queries kasi NAGBUBUFFER SHIT

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
type: {
  type: String,
  required: false, 
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

const userbusinessClearance = db.model('businessClearance', businessClearanceSchema); 


// BARANGAY ID --------------------
const BarangayIDSchema = new Schema({
  typeOfDocument:{type: String,required: true,index: true}, 
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
  typeOfDocument:{type: String,required: true,index: true}, 
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
  typeOfDocument:{type: String,required: true,index: true},
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




// BARANGAY CERTIFICATE --------------------
const barangayCertificateSchema = new Schema({
  residentName: { type: String,required: true,},
  typeOfDocument:{type: String,required: true,index: true}, 
  userId: {type: String,  required: true,},
  address: {type: String,required: true},
  reasonOfRequest: {type: String,required: true},
  pickUpDate: {type: String, required: true},
  modeOfPayment: { type: String, required: true },
  reference: {type: String,},
  status: {type: String,default: 'New'},
});

const userCertificate = db.model('barangaycertificate', barangayCertificateSchema);




//---------------- MODULE EXPORTS ------------------------

  
  module.exports = {
    userIndigency,
    userbusinessClearance,
    userBarangayID,
    userInstallation,
    userConstruction,
    userCertificate
  };




