//
//  PhotoUrls.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/27/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

class PhotoUrls {
    var raw: String?
    var full: String?
    var regular: String?
    var small: String?
    var thumb: String?
    
    // MARK: - Static methods
    static func createObject(fromData data: [String: Any]) -> PhotoUrls {
        
        let urls = PhotoUrls()
        urls.raw = data["raw"] as? String
        urls.full = data["full"] as? String
        urls.regular = data["regular"] as? String
        urls.small = data["small"] as? String
        urls.thumb = data["thumb"] as? String
        
        return urls
    }
}
