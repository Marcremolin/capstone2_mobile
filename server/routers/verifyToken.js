// Using the authentication middleware to protect sensitive routes and data.

const jwt = require('jsonwebtoken');
const config = require('../config/config');

const verifyToken = (req, res, next) => {
  const token = req.header('Authorization');
  console.log('Received token:', token);

  if (!token || !token.startsWith('Bearer ')) {
    console.log('Token missing or invalid format');
    return res.status(401).json({ message: 'Unauthorized' });
  }
  
  const tokenWithoutBearer = token.slice(7); 
    console.log('Secret Key:', config.secretKey);
  jwt.verify(tokenWithoutBearer, config.secretKey, (err, decoded) => {
    if (err) {
        console.error('Token verification error:', err);
        return res.status(401).json({ message: 'Token is not valid' });

    } else {
        console.log('Decoded user data:', decoded);


        if (!decoded._id) {
          console.error('User ID missing in token payload');
          return res.status(401).json({ message: 'User ID is missing in the token payload' });
        }
  

        const currentTime = Math.floor(Date.now() / 1000); 
      if (decoded.exp && currentTime >= decoded.exp) {
        return res.status(401).json({ message: 'Token has expired' });
      }

      req.user = decoded;
      next();
    }
  });
};

module.exports = verifyToken;






