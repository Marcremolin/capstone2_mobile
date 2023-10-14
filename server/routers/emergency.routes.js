
const router = require('express').Router(); 
const EmergencyController  = require("../controller/emergency.controller")
router.post('/emergencySignal',EmergencyController.createEmergencySignal);

module.exports = router;