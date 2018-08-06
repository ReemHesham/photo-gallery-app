//
//  Photo.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/27/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

class Photo {
    var id: String?
    var createdAt: String?
    var updatedAt: String?
    var width: Int?
    var height: Int?
    var description: String?
    var color: String?
    var urls: PhotoUrls?
    var likes: Int?
    
    // MARK: - Static methods
    static func createObject(fromData data: [String: Any]) -> Photo {
        
        let photo = Photo()
        photo.id = data["id"] as? String
        photo.createdAt = data["created_at"] as? String
        photo.updatedAt = data["updated_at"] as? String
        photo.width = data["width"] as? Int
        photo.height = data["height"] as? Int
        photo.description = data["description"] as? String
        photo.color = data["color"] as? String
        photo.likes = data["likes"] as? Int
        if let urlsDictionary = data["urls"] as? [String: Any] {
            photo.urls = PhotoUrls.createObject(fromData: urlsDictionary)
        }

        return photo
    }
}
