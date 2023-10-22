// services/announcementService.js
const announcement = require('../model/announcement.model');
class AnnouncementService {
  async getAllAnnouncements() {
    try {
      const announcements = await announcement.find();
      return announcements;
    } catch (error) {
      throw error;
    }
  }

  }
  
  module.exports = new AnnouncementService();
  















  // async getImageData(announcementId) {
  //   try {
  //     const announcementData = await Announcement.findById(announcementId);
  //     if (announcementData) {
  //       return announcementData.imageData; // Replace with your image field
  //     } else {
  //       return null; // Image not found
  //     }
  //   } catch (error) {
  //     throw error;
  //   }
  // }


//   async getImageData(announcementId, filename) {
//     try {
//       const announcementData = await announcement.findById(announcementId);

//       if (announcementData) {
//         // You need to find the specific image data within the announcement based on the filename.
//         const imageData = announcementData.images.find(image => image.filename === filename);

//         if (imageData) {
//           return imageData; // You can return the entire image data here if needed.
//         } else {
//           return null; // Image with the provided filename not found.
//         }
//       } else {
//         return null; // Announcement with the provided announcementId not found.
//       }
//     } catch (error) {
//       throw error;
//     }
//   }
// }





































//   //2ND METHOD
//   async getImageData(announcementId, imageId) {
//     try {
//       const announcementData = await announcement.findById(announcementId);

//       if (announcementData) {
//         // You need to find the specific image data within the announcement based on imageId.
//         const imageData = announcementData.images.find(image => image._id == imageId);

//         if (imageData) {
//           return imageData.filename;
//         } else {
//           return null; // Image with the provided imageId not found.
//         }
//       } else {
//         return null; // Announcement with the provided announcementId not found.
//       }
//     } catch (error) {
//       throw error;
//     }
//   }
// }








// async getImageData(announcementId) {
//   try {
//     const announcementData = await announcement.findById(announcementId);
//     if (announcementData) {
//       return announcementData.filename; // Assuming filename stores image data.
//     } else {
//       return null;
//     }
//   } catch (error) {
//     throw error;
//   }
// }
// }

module.exports = new AnnouncementService();
