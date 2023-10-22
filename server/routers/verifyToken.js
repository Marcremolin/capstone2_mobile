// Middleware: verifyToken
// Using the authentication middleware is recommended to protect sensitive routes and data.
// By using the middleware, you ensure that only authenticated and authorized users can access their profile data.

const jwt = require('jsonwebtoken');
const config = require('../config/config');

const verifyToken = (req, res, next) => {
  const token = req.header('Authorization');
  console.log('Received token:', token);

  if (!token) {
    console.log('Token missing');
    return res.status(401).json({ message: 'Unauthorized' });
  }

  try {
    const decoded = jwt.verify(token, config.secretKey);
    console.log('Decoded user data:', decoded);
    req.user = decoded;
    next();
  } catch (error) {
    console.log('Token verification error:', error);
    res.status(401).json({ message: 'Token is not valid' });
  }
};

module.exports = verifyToken;
