//
//  PhotoSliderCache.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/1/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

class PhotoSliderCache: NSCache<AnyObject, AnyObject> {

    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector:#selector(NSMutableArray.removeAllObjects), name: Notification.Name.UIApplicationDidReceiveMemoryWarning, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
