//
//  PhotoSliderRouter.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/28/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit

class PhotoSliderRouter {
    
    let photoSliderStoryboardName = "PhotoSlider"
    let photoDetailsViewControllerID = "PhotoDetailsViewController"
    let sliderNavigationControllerID = "SliderNavigationController"
    
    func instantiatePhotoDetailsViewController() -> UIViewController {
        return UIStoryboard(name: photoSliderStoryboardName, bundle: nil).instantiateViewController(withIdentifier: photoDetailsViewControllerID)
    }
    
    func instantiateSliderPageNavigationController() -> UINavigationController {
        guard let sliderNavigationController = UIStoryboard(name: photoSliderStoryboardName, bundle: nil).instantiateViewController(withIdentifier: sliderNavigationControllerID) as? UINavigationController else {
            return UINavigationController()
        }
        return sliderNavigationController
    }

}
