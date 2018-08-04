//
//  Photo.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/27/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

class Photo: NSObject {
    var id: String?
    var createdAt: String?
    var updatedAt: String?
    var width: Int?
    var height: Int?
    var photoDescription: String?
    var color: String?
    var urls: PhotoUrls?
    var likes: Int?
    var user: User?
    
    func getOwnerName() -> String {
        return self.user?.name ?? ""
    }
    
    func getPhotoSmallUrl() -> String {
        return self.urls?.small ?? ""
    }
    
    // MARK: - Static methods
    static func createObject(fromData data: [String: Any]) -> Photo {
        
        let photo = Photo()
        photo.id = data["id"] as? String
        photo.createdAt = data["created_at"] as? String
        photo.updatedAt = data["updated_at"] as? String
        photo.width = data["width"] as? Int
        photo.height = data["height"] as? Int
        photo.photoDescription = data["description"] as? String
        photo.color = data["color"] as? String
        photo.likes = data["likes"] as? Int
        if let urlsDictionary = data["urls"] as? [String: Any] {
            photo.urls = PhotoUrls.createObject(fromData: urlsDictionary)
        }
        if let userDictionary = data["user"] as? [String: Any] {
            photo.user = User.createObject(fromData: userDictionary)
        }

        return photo
    }

    /**
     Parse photos response.
     - parameter
     data: array of dictionary contains the response data [[String: Any]].
     - return : Array of Photo object.
     */
    static func parsePhotosResponse(_ data: [[String: Any]]) -> [Photo] {
        var photos = [Photo]()
        //Parsing photos array
        for photo in data {
            photos.append(Photo.createObject(fromData: photo))
        }
        return photos
    }
}
