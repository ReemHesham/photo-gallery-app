//
//  APIClient.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/27/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation
import Alamofire

class APIClient {
    
    /**
     Send request to server and retrive response.
     
     - parameter
     pageNumber: Integer represents the current page number
     completion: The completion block, send either the reponse as [[String: Any]] or nil in case or error.
     */
    func getPhotoes(_ pageNumber: Int, completion: @escaping (Any?, String?) -> Void) {
        let url = "\(URLs.baseUrl)\(URLs.photos)?client_id=\(clientId)&page=\(pageNumber)&per_page=\(photosPerPage)"
        Alamofire.request(url).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode else {
                completion(nil, Errors.otherError)
                return
            }
            switch statusCode {
            case 200:
                if let data = response.result.value  as? [[String: Any]] {
                    completion(data, nil)
                }
            default:
                completion(nil, Errors.otherError)
            }
        }
    }
}
