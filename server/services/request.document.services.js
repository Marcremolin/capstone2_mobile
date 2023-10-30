//STORE THE DATA ENTERED BY USER IN FRONTEND 
const Model = require("../model/request.document.model");

async function createCertificateOfIndigency(data) {
  try {
    console.log('Data received:', data); 

    if (!data) {
      throw new Error('Data is empty'); 
    }

    const result = await Model.userIndigency.create(data);
    console.log('Data stored:', result);
    return result;
  } catch (error) {
    console.error('Error storing data:', error);
    throw error;
  }
}



async function createBarangayCertificate(data) {
  return await Model.userCertificate.create(data);
}

async function createBusinessClearance(data) {
  console.log("Data received from frontend:", data); 
  const result = await Model.userBusinessClearance.create(data); 
  console.log("Data stored in userBusinessClearance schema:", result);
  return result;
}

async function createBarangayID(data) {
  return await Model.userBarangayID.create(data);
}

async function createInstallationPermit(data) {
  return await Model.userInstallation.create(data);
}

async function createConstructionPermit(data) {
  return await Model.userConstruction.create(data);
}
//----------------- GET SUMMARY OF REQUEST ------------------------
async function getRequestsForUser(userId) {
  try {
    // To store the results for each document type
    const requests = [];

    // Query of each document type and push the results into the 'requests' array
    const certificateOfIndigencyRequests = await Model.userIndigency.find({ userId });
    const certificateRequests = await Model.userCertificate.find({ userId });
    const businessClearanceRequests = await Model.userBusinessClearance.find({ userId });
    const barangayIDRequests = await Model.userBarangayID.find({ userId });
    const installationRequests = await Model.userInstallation.find({ userId });
    const constructionRequests = await Model.userConstruction.find({ userId });

    // Push the results of each query into the 'requests' array
    requests.push(...certificateOfIndigencyRequests);
    requests.push(...certificateRequests);
    requests.push(...businessClearanceRequests);
    requests.push(...barangayIDRequests);
    requests.push(...installationRequests);
    requests.push(...constructionRequests);

    return requests;
  } catch (error) {
    console.error('Error retrieving user requests:', error);
    throw error;
  }
}
module.exports = {
  createCertificateOfIndigency,
  createBarangayCertificate,
  createBusinessClearance,
  createBarangayID,
  createInstallationPermit,
  createConstructionPermit,
  getRequestsForUser, 

};



