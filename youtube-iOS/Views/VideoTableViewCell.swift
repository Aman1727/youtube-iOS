//
//  VideoTableViewCell.swift
//  youtube-iOS
//
//  Created by Aman on 21/11/21.
//

import UIKit

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
   
    @IBOutlet weak var titleTable: UILabel!
    
    @IBOutlet weak var dataLabel: UILabel!
    
    var video:Video?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(_ v:Video) {
        self.video = v
        
//        Ensure that we have a video
        guard self.video != nil else {
            return
        }
        
//        Set the title
        self.titleTable.text = video!.title
        
//        Set the date
        let df = DateFormatter()
        df.dateFormat = "EEEE, MMM d, yyyy"
        self.dataLabel.text = df.string(from: video!.published)
        
//      Set the thumbnail
        guard self.video!.thumbnail != "" else {
                    return
        }
          
//        Check cache before downloading the data
        if let cachedData = CacheManager.getVideoCache(self.video!.thumbnail) {
            let image = UIImage(data: cachedData)
//            Set the imageview
            self.thumbnailImageView.image = image
            return
        }
        
        
//      Download the thumbnail data
        let url = URL(string: self.video!.thumbnail)
        
//        Get the shared url session object
        let session  = URLSession.shared
        
//        Create a data task
        
        let dataTask = session.dataTask(with: url!) { data, reponse, error in
            
            if error != nil || data == nil {
                return
            }
            
            if url!.absoluteString != self.video!.thumbnail {
//                Video cell has been recycled for another video and no longer matches the thumbnail that was downloaded
                return
            }
            
//            Create the image object
            let image = UIImage(data: data!)
            CacheManager.setVideoCache(url!.absoluteString, data)
//            Set the imageview
            DispatchQueue.main.async {
                self.thumbnailImageView.image = image
            }
            
        }
        
        dataTask.resume()
        
    }


      
    
}
