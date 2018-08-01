//
//  PhotoDetailsPageViewController.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/1/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit

class PhotoDetailsPageViewController: UIPageViewController {

    var photoPageViewModel: PhotoPageViewModel?
    fileprivate var currentIndex: Int = 0

    func configure(_ viewModel: PhotoPageViewModel) {
        photoPageViewModel = viewModel
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self

        guard let viewModel = photoPageViewModel else {
            return
        }
        setPage(with: viewModel.initialIndex)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPage(with index:Int) {
        if let viewController = photoViewController(for: index) {
            setViewControllers([viewController], direction: (index > currentIndex ? .forward : .reverse), animated: true, completion: nil)
            
            currentIndex = index
        }
    }
    
    fileprivate func indexOfSlideForViewController(viewController: UIViewController) -> Int {
        guard let viewController = viewController as? PhotoDetailsViewController, let viewModel = viewController.photoDetailsViewModel, let pageViewModel = photoPageViewModel else {
            fatalError("Unexpected view controller type in page view controller.")
        }
        return pageViewModel.indexOfViewController(with: viewModel)
    }

    fileprivate func photoViewController(for pageIndex: Int) -> PhotoDetailsViewController? {

        guard let viewController = PhotoSliderRouter.instantiatePhotoDetailsViewController() as? PhotoDetailsViewController, let viewModel = photoPageViewModel else {
            fatalError("Unable to instantiate a PhotoDetailsViewController")
        }
        viewController.config(viewModel.createPhotoDetailsViewModel(for: pageIndex))
        return viewController
    }
    
}
// MARK: UIPageViewControllerDataSource
extension PhotoDetailsPageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        let viewControllerIndex = indexOfSlideForViewController(viewController: viewController)
        let previousIndex = viewControllerIndex - 1
        guard previousIndex >= 0, let viewModel = photoPageViewModel, viewModel.getPhotosCount() > previousIndex else {
            return nil
        }
        return photoViewController(for: previousIndex)

    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let viewControllerIndex = indexOfSlideForViewController(viewController: viewController)
        let nextIndex = viewControllerIndex + 1
        guard let viewModel = photoPageViewModel, viewModel.getPhotosCount() > nextIndex else {
            return nil
        }
        return photoViewController(for: nextIndex)
    }
    
}

// MARK: UIPageViewControllerDelegate

extension PhotoDetailsPageViewController: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed, let viewController = pageViewController.viewControllers?.last else {
            return
        }
        currentIndex = indexOfSlideForViewController(viewController: viewController)
    }
}
