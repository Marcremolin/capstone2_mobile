const DocumentRequestServices = require("../services/request.document.services");
exports.createDocumentRequest = async (req, res, next) => {
  try {
    console.log('Request Body:', req.body);

    const {
      userId,
      address,
      typeOfDocument,
      businessName,
      pickUpDate,
      reasonOfRequest,
      modeOfPayment,
      reference,
      status
    } = req.body;

    console.log("Type of Document:", typeOfDocument);

    let documentRequest;

    console.log("Extracted Data:");
    console.log("userId:", userId);
    console.log("address:", address);
    console.log("businessName:", businessName);
    console.log("typeOfDocument:", typeOfDocument);
    console.log("pickUpDate:", pickUpDate);
    console.log("reasonOfRequest:", reasonOfRequest);
    console.log("modeOfPayment:", modeOfPayment);
    console.log("reference:", reference);
    console.log("status:", status);

    switch (typeOfDocument) {
      case "CertificateOfIndigency":
        console.log("Creating CertificateOfIndigency request.");
        documentRequest = await DocumentRequestServices.createCertificateOfIndigency(req.body);
        break;
      case "BusinessClearance":
        console.log("Creating BusinessClearance request.");
        documentRequest = await DocumentRequestServices.createBusinessClearance({
          ...req.body,
          businessName: businessName,
          businessAddress: address,
        });
        break;
      case "BarangayID":
        console.log("Creating BarangayID request.");
        documentRequest = await DocumentRequestServices.createBarangayID(req.body);
        break;
      case "InstallationPermit":
        console.log("Creating InstallationPermit request.");
        documentRequest = await DocumentRequestServices.createInstallationPermit(req.body);
        break;
      case "ConstructionPermit":
        console.log("Creating ConstructionPermit request.");
        documentRequest = await DocumentRequestServices.createConstructionPermit(req.body);
        break;
      case "BarangayCertificate":
        console.log("Creating BarangayCertificate request.");
        documentRequest = await DocumentRequestServices.createBarangayCertificate(req.body);
        break;
        default:
          return res.status(400).json({ status: false, error: 'Invalid document type' });
      }
  
      res.json({ status: true, success: documentRequest });
    } catch (error) {
      console.error('Request processing error:', error);
      res.status(500).json({ status: false, error: 'Internal server error', details: error.message });
    }
  };
//----------------- GET SUMMARY OF REQUEST ------------------------
exports.getSummaryOfRequests = async (req, res, next) => {
  try {
    const userId = req.user._id;  
    console.log('User ID from JWT token:', userId); 
    const requests = await DocumentRequestServices.getRequestsForUser(userId);
    
    res.json({ status: true, requests });
  } catch (error) {
    next(error);
  }
};
