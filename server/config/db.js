const mongoose = require('mongoose'); 
const connection = mongoose.createConnection('mongodb://127.0.0.1:27017/capstone').on('open',()=> {
console.log("MongoDB CONNECTED");

}).on('error',()=>{
    console.log("MongoDB Connection ERRORR xxxx");

})

module.exports = connection;