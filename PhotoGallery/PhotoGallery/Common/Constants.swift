//
//  Constants.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/28/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

enum URLs {
    static let baseUrl = "https://api.unsplash.com"
    static let photos = "/photos"
}

let photosPerPage = 30
let clientId = "\(Bundle.main.object(forInfoDictionaryKey: "CLIENT_ID") as? String ?? "")"
