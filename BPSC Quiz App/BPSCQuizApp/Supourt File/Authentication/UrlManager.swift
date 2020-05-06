//
//  BaseUrl.swift
//  BPSCQuizApp
//
//  Created by Arika Afrin Boshra on 10/3/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import UIKit

class UrlManager: NSObject {
    
    private static let DEV_BASE_URL = "http://103.192.157.61:85/api/"

    class func baseURL()->String {
        return DEV_BASE_URL
    }
    
//    func findRepositories( pathwithOutq:String, matching query: String)-> URL {
//          let api = UrlManager.baseURL()
//          let endpoint = "\(pathwithOutq)?q=\(query)"
//          let url = (URL(string: api + endpoint) ?? URL(string: "https://www.google.com"))!
//          return url
//      }
     
}


extension UIImage {
    
    static let cache = NSCache< NSString, UIImage >()
    
    static func downloadImageAndCache(url: URL, completion: @escaping(_ image: UIImage?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, responseUrl, error in
            var downloadedImage: UIImage?
            
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            
            if downloadedImage != nil {
                cache.setObject(downloadedImage!, forKey: url.absoluteString as NSString)
            }
            
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }.resume()
    }
    
    
    static func getImage(url: URL, completion: @escaping(_ image: UIImage?) -> ()) {
        
        if let image = cache.object(forKey: url.absoluteString as NSString) {
            
            completion(image)
        }
        else {
            downloadImageAndCache(url: url, completion: completion)
        }
    }
    
    
    // download image without caching
    
    static func downloadImage(url: URL, completion: @escaping(_ image: UIImage?) -> ()) {
        
        URLSession.shared.dataTask(with: url) { data, responseUrl, error in
            var downloadedImage: UIImage?
            
            if let data = data {
                downloadedImage = UIImage(data: data)
            }
            
            DispatchQueue.main.async {
                completion(downloadedImage)
            }
        }.resume()
    }
}
