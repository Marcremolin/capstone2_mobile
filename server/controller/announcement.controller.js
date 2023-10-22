const AnnouncementService = require('../services/announcement.service');
class AnnouncementController {
  async getAllAnnouncements(req, res) {
    try {
      const announcements = await AnnouncementService.getAllAnnouncements();
      res.json(announcements);
    } catch (error) {
      res.status(500).json({ error: 'Internal Server Error' });
    }
  }
}

module.exports = new AnnouncementController();

































// New method to get image data
// async getImage(req, res) {
//   const { announcementId } = req.params;

//   try {
//     const imageData = await AnnouncementService.getImageData(announcementId);
//     if (imageData) {
//       // Send the image data as a response
//       res.setHeader('Content-Type', 'image/jpeg'); // Adjust content type as needed
//       res.send(imageData);
//     } else {
//       res.status(404).json({ error: 'Image not found' });
//     }
//   } catch (error) {
//     res.status(500).json({ error: 'Internal Server Error' });
//   }
// }


// }

//   try {
//     // Serve the image by sending the file
//     res.sendFile(`path-to-your-image-directory/${filename}`);
//   } catch (error) {
//     res.status(500).json({ error: 'Internal Server Error' });
//   }
// }
// }






























//   //2ND METHOD
//   async getImage(req, res) {
//     const { announcementId, imageId } = req.query; // Use query parameters to pass IDs

//     try {
//       const imageUrl = await AnnouncementService.getImageUrl(announcementId, imageId);
//       if (imageUrl) {
//         res.json({ imageUrl });
//       } else {
//         res.status(404).json({ error: 'Image not found' });
//       }
//     } catch (error) {
//       res.status(500).json({ error: 'Internal Server Error' });
//     }
//   }
// }

//    // New method to get image data
//    async getImage(req, res) {
//     const { id } = req.params;
//     try {
//       const imageUrl = await AnnouncementService.getImageUrl(id);
//       if (imageUrl) {
//         res.json({ imageUrl });
//       } else {
//         res.status(404).json({ error: 'Image not found' });
//       }
//     } catch (error) {
//       res.status(500).json({ error: 'Internal Server Error' });
//     }
//   }
// }

// module.exports = new AnnouncementController();
