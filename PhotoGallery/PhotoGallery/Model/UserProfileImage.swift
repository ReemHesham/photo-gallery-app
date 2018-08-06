//
//  UserProfileImage.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/3/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

class UserProfileImage {
    var small: String?
    var medium: String?
    var large: String?
    
    // MARK: - Static methods
    static func createObject(fromData data: [String: Any]) -> UserProfileImage {
        
        let urls = UserProfileImage()
        urls.small = data["small"] as? String
        urls.medium = data["medium"] as? String
        urls.large = data["large"] as? String
        
        return urls
    }
}
