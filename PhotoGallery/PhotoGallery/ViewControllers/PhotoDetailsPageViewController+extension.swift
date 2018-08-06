//
//  PhotoDetailsPageViewController+extension.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/2/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit

extension PhotoDetailsPageViewController {
    
    // MARK: Gestures
    
    @objc func handleTapGesture(_ gesture:UITapGestureRecognizer) {
        setUpNavigationBar(isNavigationBarHidden == true)
        setUpBottomView()
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let viewController = pagerHelper.photoViewController(for: currentIndex) else {
            return
        }
        animationHelper.handlePanGesture(gesture, viewController: viewController)
    }
    
    // MARK: Actions
    func setUpNavigationBar(_ isVisible: Bool) {
        isNavigationBarHidden = !isVisible
        
        UIView.animate(withDuration: 0.23, delay: 0.0, options: .beginFromCurrentState, animations: { () -> Void in
            
            self.navigationController?.navigationBar.alpha = (isVisible ? 1.0 : 0.0)
            
        }, completion: nil)
        
        self.setNeedsStatusBarAppearanceUpdate()
    }

    func setUpBottomView() {
        pagerHelper.photoViewController(for: currentIndex)?.setUpBottomView()
    }

    @objc func share(_ sender: Any) {
        guard let viewModel = photoPageViewModel else {
            return
        }
        let photoUrl = viewModel.getPhotoUrl(at: currentIndex)
        let activityViewController = UIActivityViewController(activityItems: [photoUrl], applicationActivities: nil)
        // so that iPads won't crash
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        self.present(activityViewController, animated: true, completion: nil)
    }

    @objc func dismiss(_ sender: Any) {
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: { () -> Void in
            
            self.navigationController?.navigationBar.alpha = 0.0
            self.navigationController?.view.alpha = 0.0
            self.view.alpha = 0.0
            self.pagerHelper.photoViewController(for: self.currentIndex)?.photoImage?.alpha = 0.0
            
        }, completion: { (_) in
            self.dismiss(animated: true, completion: nil)
        })
    }
}
