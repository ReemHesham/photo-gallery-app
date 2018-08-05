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
    var currentIndex: Int = 0
    var isNavigationBarHidden = false

    var pagerHelper: PagerHelper!
    var animationHelper: AnimationHelper!

    func configure(_ viewModel: PhotoPageViewModel) {
        photoPageViewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        
        setupNavigationBar()
        setupViewGestures()

        guard let viewModel = photoPageViewModel else {
            return
        }
        currentIndex = viewModel.initialIndex
        animationHelper = AnimationHelper(self, presentingViewController: self.presentingViewController, navController: self.navigationController)
        pagerHelper = PagerHelper(self, currentIndex: currentIndex, photo: viewModel.getPhoto(at: currentIndex))
    }
    
    private func setupNavigationBar() {
        self.navigationController?.view.backgroundColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(dismiss(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
        navigationItem.rightBarButtonItem?.accessibilityIdentifier = "Share"
    }
    
    private func setupViewGestures() {
        var gestures = gestureRecognizers
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        gestures.append(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        gestures.append(panGesture)
        view.gestureRecognizers = gestures
    }
    
    func indexOfSlideForViewController(viewController: UIViewController) -> Int {
        guard let viewController = viewController as? PhotoDetailsViewController, let viewModel = viewController.photoDetailsViewModel, let pageViewModel = photoPageViewModel else {
            fatalError("Unexpected view controller type in page view controller.")
        }
        return pageViewModel.indexOfViewController(with: viewModel)
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
        setUpNavigationBar(true)
        pagerHelper.selectedPhoto = viewModel.getPhoto(at: previousIndex)
        return pagerHelper.photoViewController(for: previousIndex)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let viewControllerIndex = indexOfSlideForViewController(viewController: viewController)
        let nextIndex = viewControllerIndex + 1
        guard let viewModel = photoPageViewModel, viewModel.getPhotosCount() > nextIndex else {
            return nil
        }
        setUpNavigationBar(true)
        pagerHelper.selectedPhoto = viewModel.getPhoto(at: nextIndex)
        return pagerHelper.photoViewController(for: nextIndex)
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
