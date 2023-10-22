const crypto = require('crypto');
const secretKey = crypto.randomBytes(32).toString('hex'); // Generates a 256-bit (32-byte) random key in hexadecimal format

module.exports = {
  secretKey: secretKey,
};

//generally not recommended to include your secret key directly in your source code, including verifyToken.js or app.js. Storing the secret key in your code can expose it to potential security risks, especially if your code repository is public or if someone gains access to your codebase.