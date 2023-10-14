const DocumentRequestServices = require("../services/request.document.services");

exports.createDocumentRequest = async (req, res, next) => {
  try {
    console.log('Request Body:', req.body);

    const {
      userId,
      userAddress,
      typeOfDocument,
      dateOfPickUp,
      reasonForRequesting,
      paymentMethod,
      paymentReferenceNumber,
      status
    } = req.body;

    let documentRequest;

    console.log("Extracted Data:");
    console.log("userId:", userId);
    console.log("userAddress:", userAddress);
    console.log("typeOfDocument:", typeOfDocument);
    console.log("dateOfPickUp:", dateOfPickUp);
    console.log("reasonForRequesting:", reasonForRequesting);
    console.log("paymentMethod:", paymentMethod);
    console.log("paymentReferenceNumber:", paymentReferenceNumber);
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
          businessName: userAddress,
          businessAddress: userAddress, 
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
