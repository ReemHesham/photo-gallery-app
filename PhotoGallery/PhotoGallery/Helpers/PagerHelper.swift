//
//  PagerHelper.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/5/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit

class PagerHelper {
    
    var pageViewController: UIPageViewController?
    var currentIndex: Int = 0
    fileprivate let photoSliderCache = NSCache<AnyObject, AnyObject>()
    var selectedPhoto: Photo?
    
    init(_ pageViewController: UIPageViewController, currentIndex: Int, photo: Photo) {
        self.pageViewController = pageViewController
        self.currentIndex = currentIndex
        self.selectedPhoto = photo
        setPage(with: currentIndex, photo: photo)
    }
    
    func setPage(with index:Int, photo: Photo) {
        selectedPhoto = photo
        if let viewController = photoViewController(for: index) {
            pageViewController?.setViewControllers([viewController], direction: (index > currentIndex ? .forward : .reverse), animated: true, completion: nil)
            
            currentIndex = index
            selectedPhoto = photo
        }
    }

    func photoViewController(for pageIndex: Int) -> PhotoDetailsViewController? {
        
        if let cachedViewController = photoSliderCache.object(forKey: pageIndex as AnyObject) as? PhotoDetailsViewController {
            return cachedViewController
        }
        guard let viewController = PhotoSliderRouter().instantiatePhotoDetailsViewController() as? PhotoDetailsViewController, let photo = selectedPhoto else {
            fatalError("Unable to instantiate a PhotoDetailsViewController")
        }
        viewController.config(PhotoDetailsViewModel(photo))
        photoSliderCache.setObject(viewController, forKey: pageIndex as AnyObject)
        return viewController
    }
}
