//
//  AnimationHelper.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/5/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit

class AnimationHelper {

    var pagerViewController: UIPageViewController?
    var presentingViewController: UIViewController?
    var navController: UINavigationController?
    var originPanViewCenter:CGPoint = .zero
    var panViewCenter:CGPoint = .zero
    var panDismissTolerance:CGFloat = 30.0
    var stepAnimate:((_ offset:CGFloat, _ viewController:UIViewController) -> Void) = { _,_ in }
    var restoreAnimation:((_ viewController:UIViewController) -> Void) = { _ in }
    var dismissAnimation:((_ viewController:UIViewController, _ panDirection:CGPoint, _ completion: @escaping () -> Void) -> Void) = { _,_,_ in }
    
    init(_ pagerViewController: UIPageViewController?, presentingViewController: UIViewController?, navController: UINavigationController?) {
        self.pagerViewController = pagerViewController
        self.presentingViewController = presentingViewController
        self.navController = navController
        prepareAnimations()
    }
    
    func prepareAnimations() {
        stepAnimate = { step, viewController in
            
            if let viewController = viewController as? PhotoDetailsViewController {
                if step == 0 {
                    viewController.photoImage?.layer.shadowRadius = 10
                    viewController.photoImage?.layer.shadowOpacity = 0.3
                } else {
                    let alpha = CGFloat(1.0 - step)
                    
                    viewController.handleBottomViewAppearance(isHidden: true)
                    self.navController?.navigationBar.alpha = 0.0
                    self.navController?.view.backgroundColor = UIColor.black.withAlphaComponent(max(0.2, alpha * 0.9))
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
                    
                    let topHeight = (self.navController?.navigationBar.frame.height ?? 0.0) + UIApplication.shared.statusBarFrame.height * 2
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
                    
                    if var frame = viewController.photoImage?.frame, let height = self.pagerViewController?.view.frame.size.height {
                        frame.origin.y = (velocity > 0 ? height : -frame.size.height)
                        viewController.photoImage?.frame = frame
                    }
                    
                    viewController.photoImage?.alpha = 0.0
                    
                }, completion: { (_: Bool) -> Void in
                    
                    completion()
                    
                })
            }
        }
    }

    func handlePanGesture(_ gesture: UIPanGestureRecognizer, viewController: UIViewController) {
        guard let viewController = viewController as? PhotoDetailsViewController, let pageViewController = pagerViewController else {
            return
        }
        
        switch gesture.state {
        case .began:
            presentingViewController?.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            
            originPanViewCenter = pageViewController.view.center
            panViewCenter = pageViewController.view.center
            
            stepAnimate(0, viewController)
            
        case .changed:
            let translation = gesture.translation(in: pageViewController.view)
            panViewCenter = CGPoint(x: panViewCenter.x + translation.x, y: panViewCenter.y + translation.y)
            
            gesture.setTranslation(.zero, in: pageViewController.view)
            
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
                    
                    self.navController?.view.alpha = 0.0
                    pageViewController.view.alpha = 0.0
                    viewController.view.alpha = 0.0
                }, completion:nil)
                dismissAnimation(viewController, gesture.velocity(in: gesture.view), {
                    
                    pageViewController.dismiss(animated: true, completion: nil)
                    
                })
            } else {
                UIView.animate(withDuration: 0.2, delay: 0.0, options: .beginFromCurrentState, animations: { () -> Void in
                    
                    (pageViewController as? PhotoDetailsPageViewController)?.isNavigationBarHidden = true
                    self.navController?.navigationBar.alpha = 0.0
                    self.navController?.view.backgroundColor = .black
                    
                }, completion: nil)
                
                restoreAnimation(viewController)
            }
            
        default:
            break
        }
    }
}
