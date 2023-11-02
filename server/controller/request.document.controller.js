const DocumentRequestServices = require("../services/request.document.services");

exports.createDocumentRequest = async (req, res, next) => {
  try {
    console.log('Request Body:', req.body);

    const {
      userId,
      address,
      typeOfDocument,
      pickUpDate,
      reasonOfRequest,
      modeOfPayment,
      reference,
      status
    } = req.body;

    let documentRequest;

    console.log("Extracted Data:");
    console.log("userId:", userId);
    console.log("address:", address);
    console.log("typeOfDocument:", typeOfDocument);
    console.log("pickUpDate:", pickUpDate);
    console.log("reasonOfRequest:", reasonOfRequest);
    console.log("modeOfPayment:", modeOfPayment);
    console.log("reference:", reference);
    console.log("status:", status);

    switch (typeOfDocument) {
      case "CertificateOfIndigency":
        documentRequest = await DocumentRequestServices.createCertificateOfIndigency(  
          req.body);
        break;
      case "BarangayCertificate":
        documentRequest = await DocumentRequestServices.createCertificateOfIndigency(req.body);
        break;
      case "BusinessClearance":
        documentRequest = await DocumentRequestServices.createBusinessClearance({
          ...req.body,
          businessName: address,
          businessAddress: address, 
        });
        break;
      case "BarangayID":
        documentRequest = await DocumentRequestServices.createBarangayID(  
          req.body);
        break;
      case "InstallationPermit":
        documentRequest = await DocumentRequestServices.createInstallationPermit(
          req.body);
        break;
      case "ConstructionPermit":
        documentRequest = await DocumentRequestServices.createConstructionPermit(  
          req.body);
        break;
      default:
        break;
    }

    res.json({ status: true, success: documentRequest });
  } catch (error) {
    next(error);
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
