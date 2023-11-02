const cloudinary = require('cloudinary').v2;

// import { v2 as cloudinary } from 'cloudinary'

cloudinary.config({ 
    cloud_name: 'dwevzsrnz', 
    api_key: '945357894123881', 
    api_secret: 'YCTZGib7kY-PSpzM020mlV0Gn9E',
    secure: true
  });

  
  module.exports= cloudinary;
