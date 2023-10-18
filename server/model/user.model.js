const mongoose = require('mongoose');
const bcrypt = require("bcrypt");
const db = require('../config/db')

const { Schema } = mongoose;

const userSchema = new Schema({

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
  houseNumber: {
    type: String,
    required: true,
  },
  barangay: {
    type: String,
    required: true,
  },
  district: {
    type: String,
    required: true,
  },
  city: {
    type: String,
    required: true,
  },
  region: {
    type: String,
    required: true,
  },
  nationality: {
    type: String,
    required: true,
  },
  birthplace: {
    type: String,
    required: true,
  },
  dateOfBirth: {
    type: Date,
  },
  age: {
    type: Number,
    required: true,
  },
  phoneNumber: {
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
  gender: {
    type: String,
    required: true,
  },
  homeOwnership: {
    type: String,
    required: true,
  },
  residentClass: {
    type: String,
    required: true,
  },
  emailAddress: {
    type: String,
    lowercase: true,
    required: true,
    unique: true,
  },
  votersRegistration: {
    type: String,
    required: true,
  },

  suffix: String,
  companyName: String,
  position: String,
  secondNumber: String,
  password: {
    type: String,
    required: true,
  },

  status: { type: String }

});

//Function to automatically encrypt the password
userSchema.pre('save', async function () {
  try {
    var user = this;  //referring to the user SCHEMA
    const salt = await (bcrypt.genSalt(10));
    const hashpass = await bcrypt.hash(user.password, salt); //decrypt the encrypt password from the user 

    user.password = hashpass;

  } catch (error) {
    throw error;
  }
});

userSchema.methods.comparePassword = async function (userPassword) {
  try {
    const isMatch = await bcrypt.compare(userPassword, this.password);
    return isMatch;
  } catch (error) {
    throw error;
  }


}
const UserModel = db.model('user', userSchema);

module.exports = UserModel;
