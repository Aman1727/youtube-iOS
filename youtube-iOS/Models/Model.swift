//
//  Model.swift
//  youtube-iOS
//
//  Created by Aman on 20/11/21.
//

import Foundation

protocol ModelDelegate {
    func videosFetched(_ videos: [Video])
}

class Model {
    
    var delegate:ModelDelegate?
    
    func getVideos() {
        
//        Create a URL object
        let url = URL(string: Constants.API_URL)
        
        guard url != nil else {
            return
        }
//        Get a URLSession object
        let session = URLSession.shared
        
//        Get a data task from the URLSession object
        let dataTask = session.dataTask(with: url!) { (data, response, error) in
//            Check if there were any errors
            if error != nil || data == nil {
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
//            Parsing the data into video objects
            do{
                let response = try decoder.decode(Response.self, from: data!)
                
                
                if response.items != nil {
//                    Call the "videosFetched method of the delegate"
                    DispatchQueue.main.async {
                        self.delegate?.videosFetched(response.items!)
                    }
                }
//                
//                dump(response)
            }catch {
                print("Error Parsing Data....")
            }
        }
        
        dataTask.resume()
    }
}
