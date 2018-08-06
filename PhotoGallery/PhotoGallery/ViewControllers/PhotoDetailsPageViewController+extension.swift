//
//  PhotoDetailsPageViewController+extension.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/2/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit

extension PhotoDetailsPageViewController {
    
    func prepareAnimations() {
        stepAnimate = { step, viewController in
            
            if let viewController = viewController as? PhotoDetailsViewController {
                if step == 0 {
                    viewController.photoImage?.layer.shadowRadius = 10
                    viewController.photoImage?.layer.shadowOpacity = 0.3
                } else {
                    let alpha = CGFloat(1.0 - step)
                    
                    self.photoViewController(for: self.currentIndex)?.handleBottomViewAppearance(isHidden: true)
                    self.navigationController?.navigationBar.alpha = 0.0
                    self.navigationController?.view.backgroundColor = UIColor.black.withAlphaComponent(max(0.2, alpha * 0.9))
                    viewController.view.backgroundColor = UIColor.clear
                    
                    let scale = max(0.8, alpha)
                    
                    viewController.photoImage?.center = self.panViewCenter
                    viewController.photoImage?.transform = CGAffineTransform(scaleX: scale, y: scale)
                }
            }
        }
        restoreAnimation = { viewController in
            
            if let viewController = viewController as? PhotoDetailsViewController {
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .beginFromCurrentState, animations: { () -> Void in
                    
                    self.presentingViewController?.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    
                    let topHeight = (self.navigationController?.navigationBar.frame.height ?? 0.0) + UIApplication.shared.statusBarFrame.height
                    viewController.photoImage?.center = CGPoint(x: self.originPanViewCenter.x, y: self.originPanViewCenter.y - topHeight)
                    viewController.photoImage?.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    viewController.photoImage?.layer.shadowRadius = 0
                    viewController.photoImage?.layer.shadowOpacity = 0
                    
                }, completion: nil)
            }
        }
        dismissAnimation = {  viewController, panDirection, completion in
            
            if let viewController = viewController as? PhotoDetailsViewController {
                let velocity = panDirection.y
                
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: { () -> Void in
                    
                    self.presentingViewController?.view.transform = CGAffineTransform.identity
                    
                    if var frame = viewController.photoImage?.frame {
                        frame.origin.y = (velocity > 0 ? self.view.frame.size.height : -frame.size.height)
                        viewController.photoImage?.frame = frame
                    }
                    
                    viewController.photoImage?.alpha = 0.0
                    
                }, completion: { (_: Bool) -> Void in
                    
                    completion()
                    
                })
            }
        }
    }

    // MARK: Gestures
    
    @objc func handleTapGesture(_ gesture:UITapGestureRecognizer) {
        setUpNavigationBar(isNavigationBarHidden == true)
        setUpBottomView()
    }
    
    @objc func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let viewController = photoViewController(for: currentIndex) else {
            return
        }
        
        switch gesture.state {
        case .began:
            presentingViewController?.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            
            originPanViewCenter = view.center
            panViewCenter = view.center
            
            stepAnimate(0, viewController)
            
        case .changed:
            let translation = gesture.translation(in: view)
            panViewCenter = CGPoint(x: panViewCenter.x + translation.x, y: panViewCenter.y + translation.y)
            
            gesture.setTranslation(.zero, in: view)
            
            let distanceX = fabs(originPanViewCenter.x - panViewCenter.x)
            let distanceY = fabs(originPanViewCenter.y - panViewCenter.y)
            let distance = max(distanceX, distanceY)
            let center = max(originPanViewCenter.x, originPanViewCenter.y)
            
            let distanceNormalized = max(0, min((distance / center), 1.0))
            
            stepAnimate(distanceNormalized, viewController)
            
        case .ended, .cancelled, .failed:
            let distanceY = fabs(originPanViewCenter.y - panViewCenter.y)
            
            if distanceY >= panDismissTolerance {
                UIView.animate(withDuration: 0.3, delay: 0.0, options: .beginFromCurrentState, animations: { () -> Void in
                    
                    self.navigationController?.view.alpha = 0.0
                    self.view.alpha = 0.0
                    viewController.view.alpha = 0.0
                }, completion:nil)
                dismissAnimation(viewController, gesture.velocity(in: gesture.view), {
                    
                    self.dismiss(animated: true, completion: nil)
                    
                })
            } else {
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .beginFromCurrentState, animations: { () -> Void in
                    
                    self.isNavigationBarHidden = true
                    self.navigationController?.navigationBar.alpha = 0.0
                    self.navigationController?.view.backgroundColor = .black
                    
                }, completion: nil)
                
                restoreAnimation(viewController)
            }
            
        default:
            break
        }
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
        photoViewController(for: currentIndex)?.setUpBottomView()
    }
}
