const mongoose = require('mongoose'); 
const connection = mongoose.createConnection('mongodb+srv://dbarangay:dIgrzUEvSPjrUWxu@dbarangay.nszcm1t.mongodb.net/').on('open',()=> {
console.log("MongoDB CONNECTED");

}).on('error',()=>{
    console.log("MongoDB Connection ERRORR xxxx");

})

module.exports = connection;

//mongodb+srv://dbarangay:dIgrzUEvSPjrUWxu@dbarangay.nszcm1t.mongodb.net