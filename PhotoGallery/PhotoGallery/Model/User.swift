//
//  User.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/3/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

class User {
    var id: String?
    var username: String?
    var name: String?
    var portfolioUrl: String?
    var profileImage: UserProfileImage?
    var totalPhotos: String?
    var totalLiks: String?

    // MARK: - Static methods
    static func createObject(fromData data: [String: Any]) -> User {
        
        let user = User()
        user.id = data["id"] as? String
        user.username = data["username"] as? String
        user.name = data["name"] as? String
        user.portfolioUrl = data["portfolio_url"] as? String
        user.totalPhotos = data["total_photos"] as? String
        user.totalLiks = data["total_likes"] as? String
        if let urlsDictionary = data["profile_image"] as? [String: Any] {
            user.profileImage = UserProfileImage.createObject(fromData: urlsDictionary)
        }
        
        return user
    }
}
