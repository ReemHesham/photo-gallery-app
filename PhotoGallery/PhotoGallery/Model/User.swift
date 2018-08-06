//
//  User.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/3/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

struct User: Codable {
    let id: String
    let username: String
    let name: String
    let portfolioUrl: String?
    let profileImage: UserProfileImage
    let totalPhotos: Int
    let totalLiks: Int

    // Override the property name to match the respective JSON field name
    private enum CodingKeys : String, CodingKey {
        case id
        case username
        case name
        case portfolioUrl = "portfolio_url"
        case totalPhotos = "total_photos"
        case totalLiks = "total_likes"
        case profileImage = "profile_image"
    }

}
