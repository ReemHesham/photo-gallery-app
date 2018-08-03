//
//  PhotoDetailsPageViewController.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/1/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit

class PhotoDetailsPageViewController: UIPageViewController {

    fileprivate var photoPageViewModel: PhotoPageViewModel?
    var currentIndex: Int = 0
    fileprivate let photoSliderCache = PhotoSliderCache()
    var isNavigationBarHidden = false
    var originPanViewCenter:CGPoint = .zero
    var panViewCenter:CGPoint = .zero
    var stepAnimate:((_ offset:CGFloat, _ viewController:UIViewController) -> Void) = { _,_ in }
    var restoreAnimation:((_ viewController:UIViewController) -> Void) = { _ in }
    var dismissAnimation:((_ viewController:UIViewController, _ panDirection:CGPoint, _ completion: @escaping () -> Void) -> Void) = { _,_,_ in }
    fileprivate var pageSpacing:CGFloat = 10.0
    var panDismissTolerance:CGFloat = 30.0
    var originalTransform: CGAffineTransform?
    var center: CGPoint = CGPoint(x: 0, y: 0)
    func configure(_ viewModel: PhotoPageViewModel) {
        photoPageViewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataSource = self
        delegate = self
        self.navigationController?.view.backgroundColor = UIColor.black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "back"), style: .plain, target: self, action: #selector(dismiss(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(share(_:)))
        guard let viewModel = photoPageViewModel else {
            return
        }
        originalTransform = self.presentingViewController?.view.transform
        setupViewGestures()
        prepareAnimations()
        setPage(with: viewModel.initialIndex)
    }
    
    @objc private func dismiss(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: { () -> Void in
            
            self.navigationController?.navigationBar.alpha = 0.0
            self.navigationController?.view.alpha = 0.0
            self.view.alpha = 0.0
            self.photoViewController(for: self.currentIndex)?.photoImage.alpha = 0.0
            
        }, completion: { (_) in
            self.dismiss(animated: true, completion: nil)
        })
    }
    
    @objc private func share(_ sender: Any) {
        guard let viewModel = photoPageViewModel else {
            return
        }
        let photoUrl = viewModel.getPhotoUrl(at: currentIndex)
        let activityViewController = UIActivityViewController(activityItems: [photoUrl], applicationActivities: nil)
        // so that iPads won't crash
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    private func setupViewGestures() {
        var gestures = gestureRecognizers
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        gestures.append(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        gestures.append(panGesture)
        view.gestureRecognizers = gestures
    }
    
    func setPage(with index:Int) {
        if let viewController = photoViewController(for: index) {
            setViewControllers([viewController], direction: (index > currentIndex ? .forward : .reverse), animated: true, completion: nil)
            
            currentIndex = index
        }
    }
    
    func indexOfSlideForViewController(viewController: UIViewController) -> Int {
        guard let viewController = viewController as? PhotoDetailsViewController, let viewModel = viewController.photoDetailsViewModel, let pageViewModel = photoPageViewModel else {
            fatalError("Unexpected view controller type in page view controller.")
        }
        return pageViewModel.indexOfViewController(with: viewModel)
    }

    func photoViewController(for pageIndex: Int) -> PhotoDetailsViewController? {

        if let cachedViewController = photoSliderCache.object(forKey: pageIndex as AnyObject) as? PhotoDetailsViewController {
            return cachedViewController
        }
        guard let viewController = PhotoSliderRouter.instantiatePhotoDetailsViewController() as? PhotoDetailsViewController, let viewModel = photoPageViewModel else {
            fatalError("Unable to instantiate a PhotoDetailsViewController")
        }
        viewController.config(viewModel.createPhotoDetailsViewModel(for: pageIndex))
        photoSliderCache.setObject(viewController, forKey: pageIndex as AnyObject)
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
        setUpNavigationBar(true)
        return photoViewController(for: previousIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {

        let viewControllerIndex = indexOfSlideForViewController(viewController: viewController)
        let nextIndex = viewControllerIndex + 1
        guard let viewModel = photoPageViewModel, viewModel.getPhotosCount() > nextIndex else {
            return nil
        }
        setUpNavigationBar(true)
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
