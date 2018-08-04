//
//  Photo.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/27/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

struct Photo: Codable, Equatable {
    
    let id: String
    let createdAt: String
    let updatedAt: String
    let width: Int
    let height: Int
    let photoDescription: String?
    let color: String
    let urls: PhotoUrls
    let likes: Int
    let user: User
    
    // Override the property name to match the respective JSON field name
    private enum CodingKeys : String, CodingKey {
        case id
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case width
        case height
        case photoDescription = "description"
        case color
        case likes
        case urls
        case user
    }

    static func == (lhs: Photo, rhs: Photo) -> Bool {
        return lhs.id == rhs.id
    }
    func getOwnerName() -> String {
        return self.user.name
    }
    
    func getPhotoSmallUrl() -> String {
        return self.urls.small
    }

}
