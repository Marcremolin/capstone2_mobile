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

module.exports = {
  createCertificateOfIndigency,
  createBarangayCertificate,
  createBusinessClearance,
  createBarangayID,
  createInstallationPermit,
  createConstructionPermit,
};
