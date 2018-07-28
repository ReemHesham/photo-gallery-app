//
//  PhotoRouter.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/28/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit

class PhotoRouter {
    
 static let photosStoryboardName = "Main"
 static let photoDetailsViewControllerID = "PhotoDetailsViewController"
    
    static func instantiateStartViewController() -> UIViewController {
        guard let photoDetailsVC = UIStoryboard(name: photosStoryboardName, bundle: nil).instantiateViewController(withIdentifier: photoDetailsViewControllerID) as? PhotoDetailsViewController else {
            return UIViewController()
        }
        return photoDetailsVC
    }

}
