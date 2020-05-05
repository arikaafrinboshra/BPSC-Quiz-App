//
//  UrlSessionExtention.swift
//  BPSCQuizApp
//
//  Created by Arika Afrin Boshra on 10/3/20.
//  Copyright © 2020 Arika Afrin Boshra. All rights reserved.
//

import Foundation
import UIKit

//var t = TokenUrl()
let tokenSave = UserDefaults.standard
var token = TokenUrl.shared.token
var userName = TokenUrl.shared.username
var password = TokenUrl.shared.password
let homeView = HomeViewController()
 
//var token:String = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1bmlxdWVfbmFtZSI6IjEiLCJyb2xlIjoiQWRtaW4iLCJuYmYiOjE1ODQ4NTY1MDMsImV4cCI6MTU4NDg3NDUwMywiaWF0IjoxNTg0ODU2NTAzfQ.LuUYFOiichdwSF97xEJFhdzVm48LcPaW-_kgTXNeVzA"

//################################################################################
//----->GET----->[if data comes that formation]
//################################################################################
func fetchDatawithNSDictionary(apitype: String, urlString: String, baseURL: String, completion: @escaping (Data) -> Void){
    
    guard let urlStr=urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else {return}
    guard let url : URL = URL(string: urlStr) else {return}
    var request: URLRequest = URLRequest(url:url)
    //var request: URLRequest = URLRequest(url:url)
    print(token)
    if token == "" {
        print("token is null")
    } else {
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = TimeInterval(60)
    
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (data, response, error) in
        
        
        if let response = response as? HTTPURLResponse {
            print(response.statusCode)
            
            if response.statusCode == 401 {
                print("Success")
                
                let apiUrl = "http://103.192.157.61:85/api/Authenticate/login"
                var param:[String:Any] = [:]
                
                param["username"] = userName
                param["password"] = password
                
                postDatawithNSDictionary(urlString: apiUrl, parameters: param, baseURL: "")
                {(jsonDict) in
                    do {
                        
                        let responseModel = try JSONDecoder().decode(LoginBase.self, from: jsonDict)
                        token = responseModel.successResonse?.token ?? ""
                        
                        print(token)
                        TokenUrl.shared.token = token
                        tokenSave.set(token, forKey: "saveToken")
                        homeView.viewDidLoad()
                    }
                    catch{
                        
                    }
                }
            }
        }
        if(error != nil) {
            print(error?.localizedDescription ?? "")
            DispatchQueue.main.async {
               // completion([:])
            }
        }//end of error section
            /// #############################################################
        else  {
            do {
//                let jsonDict:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                DispatchQueue.main.async {
                    
                    
                    completion(data!)
                }
            }
            catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                //    completion([:])
                }
            }
        }
    }
    task.resume()
}

func fetchDatawithNSArray(apitype: String, urlString: String, baseURL: String, completion: @escaping (NSArray) -> Void){
    
    guard let urlStr=urlString.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed) else {return}
    guard let url : URL = URL(string: urlStr) else {return}
    var request: URLRequest = URLRequest(url:url)
    
    //mark: TOken must be check in (nil)
    if token != ""{
        request.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
    }
    
    let config = URLSessionConfiguration.default
    config.timeoutIntervalForRequest = TimeInterval(60)
    
    let session = URLSession(configuration: config)
    let task = session.dataTask(with: request) { (data, response, error) in
        //having error
        if(error != nil) {
            print(error?.localizedDescription ?? "")
            DispatchQueue.main.async {
                completion([])
            }
        }//end of error section
            /// #############################################################
        else  {
            do {
                let jsonDict:NSArray = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSArray
                DispatchQueue.main.async {
                    completion(jsonDict)
                }
            }
            catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion([])
                }
            }
        }
    }
    task.resume()
    
}

//################################################################################
//--------->POST -----> without token
// let apiUrl = "http://127.0.0.1:8000/api/v1/account/login"
//    var param:[String:Any] = [:]
//    param["username"] = "abc@gmail.com"
//    param["password"] = "mamun54"
//
//
//    print(apiUrl)
//    postDatawithNSDictionary(urlString:apiUrl,parameters:param,baseURL: "") { (jsonDict) in
//
//        print(jsonDict)
//
//    }
//}

//################################################################################


func postDatawithNSDictionary(urlString: String, parameters:[String:Any], baseURL: String, completion: @escaping (Data) -> Void) {
    
    
    guard let gitUrl = URL(string: urlString) else { return }
    //print(gitUrl)
    
    let request = NSMutableURLRequest(url: gitUrl)
    
    let session = URLSession.shared
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
   // request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
    
    //
    //        guard let data = data else { return }
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        
        print("task =   ", error)
        
        if(error != nil){
            print(error?.localizedDescription ?? "")
            DispatchQueue.main.async {
                //completion([:])
            }
        }
        else  {
            
            do {
                //let jsonDict:Data = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Data
                
                
                DispatchQueue.main.async {
                    completion(data!)
                }
            }
            catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                   // completion([:])
                }
            }
        }
    }
    task.resume()
}

//################################################################################
//--------->POST -----> with token
//################################################################################
func postDatawithNSDictionarywithToken(urlString: String, parameters:[String:Any], baseURL: String, completion: @escaping (NSDictionary) -> Void) {
    
    
    guard let gitUrl = URL(string: urlString) else { return }
    //print(gitUrl)
    
    let request = NSMutableURLRequest(url: gitUrl)
    
    let session = URLSession.shared
    request.httpMethod = "POST"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
    
    request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
    
    //
    //        guard let data = data else { return }
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        
        
        if(error != nil){
            print(error?.localizedDescription ?? "")
            DispatchQueue.main.async {
              //  completion([:])
            }
        }
        else  {
            
            do {
            //    let jsonDict:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                
                DispatchQueue.main.async {
                   // completion(jsonDict)
                }
            }
            catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                 //   completion([:])
                }
            }
        }
    }
    task.resume()
}

//################################################################################
//--------->PUT -----> with token

//let apiUrl = "http:/127.0.0.1:8000/api/v1/account/notificationupdate/1"
//       var param:[String:Any] = [:]
//       param["status"] = "true"
//       print(apiUrl)
//       putDatawithNSDictionarywithToken(urlString:apiUrl,parameters:param,baseURL: "") { (jsonDict) in
//
//           print(jsonDict)
//
//       }
//################################################################################
func putDatawithNSDictionarywithToken(urlString: String, parameters:[String:Any], baseURL: String, completion: @escaping (NSDictionary) -> Void) {
    
    
    guard let gitUrl = URL(string: urlString) else { return }
    //print(gitUrl)
    
    let request = NSMutableURLRequest(url: gitUrl)
    
    let session = URLSession.shared
    request.httpMethod = "PUT"
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    request.addValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
    
    request.httpBody = try! JSONSerialization.data(withJSONObject: parameters, options: [])
    
    //
    //        guard let data = data else { return }
    let task = session.dataTask(with: request as URLRequest) { data, response, error in
        
        if(error != nil){
            print(error?.localizedDescription ?? "")
            DispatchQueue.main.async {
                completion([:])
            }
        }
        else  {
            
            do {
                let jsonDict:NSDictionary = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! NSDictionary
                
                DispatchQueue.main.async {
                    completion(jsonDict)
                }
            }
            catch {
                print(error.localizedDescription)
                DispatchQueue.main.async {
                    completion([:])
                }
            }
        }
    }
    task.resume()
}

func checkValueTypeNSArray(value:AnyObject?) -> NSArray {
    if value is NSNull || value == nil {
        return []
    }
    else {
        return value as! NSArray
    }
}
func checkValueTypeNSDict(value:AnyObject?) -> NSDictionary {
    if value is NSNull || value == nil {
        return [:]
    }
    else {
        return value as! NSDictionary
    }
}

func checkValueType(value:AnyObject?) -> String {
    if value is NSNull || value == nil {
        return ""
    }
    else {
        return "\(value!)"
    }
}

func checkValueTypeInt(value:AnyObject?) -> Int {
    if value is NSNull || value == nil {
        return 0
    }
    else {
        return value as! Int
    }
}


func uploadImage(paramName: String, fileName: String, image: UIImage) {
    
    let postUrl = UrlManager.baseURL() + "ApplicationUser/UploadProfilePicture"
    
    //let url = URL(string: postUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)

    let url = URL(string: postUrl)


    // generate boundary string using a unique per-app string
    let boundary = UUID().uuidString

    let session = URLSession.shared

    // Set the URLRequest to POST and to the specified URL
    
    var urlRequest = URLRequest(url: url!)
    urlRequest.httpMethod = "POST"

    // Set Content-Type Header to multipart/form-data, this is equivalent to submitting form data with file upload in a web browser
    
    // And the boundary is also set here
    urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    urlRequest.setValue("Bearer \(String(describing: token))", forHTTPHeaderField: "Authorization")
    //urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
    
    
    var data = Data()

    // Add the image data to the raw http request data
    data.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
    data.append("Content-Disposition: form-data; name=\"\(paramName)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
    data.append("Content-Type: image/png\r\n\r\n".data(using: .utf8)!)
    
    //data.append(image.pngData()!)
    
    // compressing data if needed.
    data.append(image.jpegData(compressionQuality: .zero)!)
    data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
    
    let jpegSize: Int = data.count
    print("size of jpeg image in KB:", Double(jpegSize) / 1024.0)

    // Send a POST request to the URL, with the data we created earlier
    session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in

        if error == nil {
            let jsonData = try? JSONSerialization.jsonObject(with: responseData!, options: .allowFragments)

            if let json = jsonData as? [String: Any] {
                print(json)
            }
        }
    }).resume()
}
