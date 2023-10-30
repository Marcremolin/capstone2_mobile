const express = require('express');
const router = express.Router();
const DocumentRequestController = require("../controller/request.document.controller");
const authenticate = require('./verifyToken');

router.post('/requestDocument', DocumentRequestController.createDocumentRequest);
router.get('/summary', authenticate, DocumentRequestController.getSummaryOfRequests);

module.exports = router;
