const express = require('express');
const router = express.Router();
const DocumentRequestController = require("../controller/request.document.controller");

router.post('/requestDocument', DocumentRequestController.createDocumentRequest);

module.exports = router;
