//
//  Utilities.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/29/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation
import Alamofire

class Utilities {
    
    /**
     isConnectedToNetwork return bool value that presents the application ability to connect to internet
     */
    static func isConnectedToNetwork() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}
