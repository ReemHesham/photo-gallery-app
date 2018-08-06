//
//  PhotoSliderRouter.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/28/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit

class PhotoSliderRouter {
    
    static let photoSliderStoryboardName = "PhotoSlider"
    static let photoDetailsPageViewControllerID = "PhotoDetailsPageViewController"
    static let photoDetailsViewControllerID = "PhotoDetailsViewController"
    static let sliderNavigationControllerID = "SliderNavigationController"
    
    static func instantiatePhotoDetailsViewController() -> UIViewController {
        return UIStoryboard(name: photoSliderStoryboardName, bundle: nil).instantiateViewController(withIdentifier: photoDetailsViewControllerID)
    }
    
    static func instantiatePhotoDetailsPageViewController() -> UIViewController {
        return UIStoryboard(name: photoSliderStoryboardName, bundle: nil).instantiateViewController(withIdentifier: photoDetailsPageViewControllerID)
    }
    
    static func instantiateSliderPageNavigationController() -> UINavigationController {
        guard let sliderNavigationController = UIStoryboard(name: photoSliderStoryboardName, bundle: nil).instantiateViewController(withIdentifier: sliderNavigationControllerID) as? UINavigationController else {
            return UINavigationController()
        }
        return sliderNavigationController
    }

}
