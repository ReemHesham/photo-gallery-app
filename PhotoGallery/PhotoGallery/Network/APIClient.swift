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
     Send request to server and retrieve response.
     
     - parameter
     pageNumber: Integer represents the current page number
     completion: The completion block, send either the reponse as [Photo] or nil in case or error.
     */
    func getPhotos(_ pageNumber: Int, completion: @escaping ([Photo]?, String?) -> Void) {
        let url = "\(URLs.baseUrl)\(URLs.photos)?client_id=\(clientId)&page=\(pageNumber)&per_page=\(photosPerPage)"
        Alamofire.request(url).responseJSON { response in
            
            guard let statusCode = response.response?.statusCode,
                200 ... 299 ~= statusCode, let data = response.data else {
                    completion(nil, Errors.otherError)
                    return
            }
            let decoder = JSONDecoder()
            do {
                let photos = try decoder.decode([Photo].self, from: data)
                completion(photos, nil)
            } catch {
                completion(nil, Errors.otherError)
            }
        }
    }
}
