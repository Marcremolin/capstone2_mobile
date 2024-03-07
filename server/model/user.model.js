
const mongoose = require('mongoose');
const db = require('../config/db')
const bcrypt = require('bcrypt');


const { Schema } = mongoose;

const userSchema = new Schema({
  _id:{
    type:String,
    required:true
},

  lastName: {
    type: String,
    required: true,
  },
  firstName: {
    type: String,
    required: true,
  },
  middleName: {
    type: String,
    
  },

  suffix: String,

  houseNumber: { 
    type: String,
    required: true,
  },
  barangay: {
    type: String,
    required: true,
  },

  cityMunicipality: {
    type: String,
    required: true,
  },
  
  district: {
    type: String,
    required: true,
  },

  province: {
    type: String,
    required: true,
  }, 

  region: {
    type: String,
    required: true,
  },

  phoneNumber: {
    type: String,

  },

  email: {
    type: String,
    lowercase: true,
    required: true,
    unique: true,
  },

  nationality: {
    type: String,
    required: true,
  },

  civilStatus: {
    type: String,
    required: true,
  },
  highestEducation: {
    type: String,

  },
  employmentStatus: {
    type: String,
  },

  homeOwnership: {
    type: String,
    required: true,
  },
  residentClass: {
    type: String,
  },

  dateOfBirth: {
    type: String,
  },
    birthPlace: {
      type: String,
      required: true,
    },
    age: {
      type: String,
      required: true,
    },
    
  sex: {
    type: String,
    required: true,
  },

  companyName: String,
  position: String,

  votersRegistration: {
    type: String,
  },
  filename: {
    public_id: {
      type: String,
      required: true
    },
    url: {
      type: String,
      required: true
    }
  },

  password: {
    type: String,
    required: true,
  },
  filename: {
    public_id: {
      type: String,
      required: true
    },
    url:{
      type: String,
      required: true 
    },

  type:{
    type:String,
    default:'resident'
},
  status:{
    type:String,
    default:'active'
},



//ADDED FOR USER VERIFICATION IN FORGET PASSWORD --- 
verificationCode: String, 
verificationCodeUsed: Boolean, 

}});

 

//Function to automatically encrypt the password
userSchema.pre('save', async function () {
  try {
    var user = this;  //referring to the user SCHEMA
    const salt = await (bcrypt.genSalt(10));
    const hashpass = await bcrypt.hash(user.password, salt); //decrypt the encrypted password from the user 

    user.password = hashpass;

  } catch (error) {
    throw error;
  }
});
userSchema.methods.comparePassword = async function (userPassword) {
  try {
    console.log('Entered Password:', userPassword);
    console.log('Hashed Password in Database:', this.password);

    const isMatch = await bcrypt.compare(userPassword, this.password);
    return isMatch;
  } catch (error) {
    throw error;
  }
};


const UserModel = db.model('user', userSchema);

module.exports = UserModel;

