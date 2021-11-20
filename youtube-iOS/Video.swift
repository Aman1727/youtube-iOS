//
//  Video.swift
//  youtube-iOS
//
//  Created by Aman on 20/11/21.
//

import Foundation

struct Video: Decodable {
    
    var videoId = ""
    var title = ""
    var description = ""
    var thumbnail = ""
    var published = Date()
    
    enum CodingKeys: String, CodingKey {
        
        case snippet
        case thumbnails
        case high
        case resourceId
        
        case published = "publishedAt"
        case title
        case description
        case thumbnail = "url"
        case videoId
        
    }
    
    init(from decoder:Decoder) throws {
        
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        
        let snippetContainer = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .snippet)
        
//        Parse title
        self.title = try snippetContainer.decode(String.self, forKey: .title)
//        Parse description
        self.description = try snippetContainer.decode(String.self, forKey: .description)
//        Parse the publish date
        self.published = try snippetContainer.decode(Date.self, forKey: .published)
        
//        Parse thumbnails
        let thumbnailContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .thumbnails)
        
        
        do {
            let highContainer = try thumbnailContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .high)
            self.thumbnail = try highContainer.decode(String.self, forKey: .thumbnail)
        }catch{
            self.thumbnail = "https://cdn.pixabay.com/photo/2018/11/18/05/16/monitoring-3822541_960_720.jpg"
        }
        
        
        let resourceIdContainer = try snippetContainer.nestedContainer(keyedBy: CodingKeys.self, forKey: .resourceId)
        
        self.videoId = try resourceIdContainer.decode(String.self, forKey: .videoId)
    }
}
