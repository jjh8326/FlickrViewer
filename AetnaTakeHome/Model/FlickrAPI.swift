//
//  FlickrAPI.swift
//  AetnaTakeHome
//
//  Created by Joe H on 11/20/21.
//

import UIKit

class FlickrAPI {
    
    static let flickrURL = "https://api.flickr.com/services/feeds/photos_public.gne?tagmode=any&format=json&nojsoncallback=1&tags="
    
    static func getGetRecentUploadsWith(searchTerm: String, completion: @escaping(_ result: [RecentUpload]) -> ()) {
        guard let url = URL(string: String(format: "%@%@", FlickrAPI.flickrURL, searchTerm)) else {
            print("Invalid URL for Flickr API")
            
            //TODO: Handle invalid searches or commas separated words
            
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let flickrData = data else {
                return
            }
            
            var recentUploads: [RecentUpload] = [RecentUpload]()

            do {
                //Convert the json into a dictionary
                let recentUploadDictionary: Dictionary = try JSONSerialization.jsonObject(with: flickrData, options:[]) as! [String: Any]
                let items: Array = recentUploadDictionary["items"] as! Array<Any>
                for i in 0..<items.count {
                    print("here")
                    let recentUploadItem = RecentUpload.init(dict: items[i] as! [String : Any])
                    recentUploads.append(recentUploadItem)
                }
            
                //completion(recentUploads)
            } catch let jsonError {
                print(jsonError)
            }
        }.resume()
    }
    
    //TODO: Use a cache
    static func fetchImage(withString URLString: String, completion: @escaping(_ result: UIImage) -> ()) {
        if let imageURL = URL(string: URLString) {
            URLSession.shared.dataTask(with: imageURL) { (data, response, error) in
                if error != nil {
                    print(error!)
                }
                
                if let imageData = data {
                    if let image = UIImage(data: imageData) {
                        completion(image)
                    }
                }
            }.resume()
        }
    }
}
