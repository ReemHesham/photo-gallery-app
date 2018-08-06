//
//  PhotosManager.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/28/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

class PhotosManager {
    static let shared: PhotosManager = {
        let instance = PhotosManager()
        return instance
    }()
    
    var photosArray: [Photo] = []
    /**
     Parse photos response.
     - parameter
     data: array of dictionary contains the response data [[String: Any]].
     - return : Array of Photo object.
     */
    func parsePhotosResponse(_ data: [[String: Any]]) -> [Photo] {
        var photos = [Photo]()
        //Parsing photos array
        for photo in data {
            photos.append(Photo.createObject(fromData: photo))
        }
        return photos
    }
}
