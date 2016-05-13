//
//  StreetArtViewAPI.swift
//  SwiftArtView
//
//  Created by Ilya Mozerov on 5/13/16.
//  Copyright © 2016 street art view. All rights reserved.
//

import Foundation
import Alamofire

private typealias JSONObject = [String : AnyObject]

final class StreetArtViewAPI {
    static let sharedInstance = StreetArtViewAPI()
    
    // API base URL.
    private let apiBaseURL = "https://street-art-server.herokuapp.com/"
    
    func getArtWorksList(completion: [ArtWork] -> Void) {
        get("artworks") { JSON in
            if let result = JSON as? [JSONObject] {
                let artWorksArray = result
                var collections: [ArtWork] = []
                for dict in artWorksArray {
                    do {
                        let artWork = try ArtWork.decode(dict)
                        collections.append(artWork)
                    } catch {
                        print("Failed to load art works")
                    }
                }
                completion(collections)
            }
        }
    }
    
    // Convenience method to perform a GET request on an API endpoint.
    private func get(endpoint: String, completion: AnyObject? -> Void) {
        request(endpoint, method: "GET", encoding: .JSON, parameters: nil, completion: completion)
    }
    
    // Convenience method to perform a POST request on an API endpoint.
    private func post(endpoint: String, parameters: [String: AnyObject]?, completion: AnyObject? -> Void) {
        request(endpoint, method: "POST", encoding: .JSON, parameters: parameters, completion: completion)
    }
    
    // Perform a request on an API endpoint using Alamofire.
    private func request(endpoint: String, method: String, encoding: Alamofire.ParameterEncoding, parameters: [String: AnyObject]?, completion: AnyObject? -> Void) {
        let URL = NSURL(string: apiBaseURL + endpoint)!
        let URLRequest = NSMutableURLRequest(URL: URL)
        URLRequest.HTTPMethod = method
        
        let request = encoding.encode(URLRequest, parameters: parameters).0
        
        print("Starting \(method) \(URL) (\(parameters ?? [:]))")
        Alamofire.request(request).responseJSON { _, response, result in
            print("Finished \(method) \(URL): \(response?.statusCode)")
            switch result {
            case .Success(let JSON):
                completion(JSON)
            case .Failure(let data, let error):
                print("Request failed with error: \(error)")
                if let data = data {
                    print("Response data: \(NSString(data: data, encoding: NSUTF8StringEncoding)!)")
                }
                
                completion(nil)
            }
        }
    }
}