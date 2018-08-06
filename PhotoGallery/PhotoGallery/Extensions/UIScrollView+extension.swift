//
//  UIScrollView+extension.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/4/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit

extension UIScrollView {

    func handleZoom(for imageViewSize: CGSize, imageSize: CGSize) {
    
        if self.zoomScale > 1 {
            
//            if let image = imageView.image {
            
                let ratioW = imageViewSize.width / imageSize.width
                let ratioH = imageViewSize.height / imageSize.height
                
                let ratio = ratioW < ratioH ? ratioW:ratioH
                
                let newWidth = imageSize.width*ratio
                let newHeight = imageSize.height*ratio
                
                let left = 0.5 * (newWidth * self.zoomScale > imageViewSize.width ? (newWidth - imageViewSize.width) : (self.frame.width - self.contentSize.width))
                let top = 0.5 * (newHeight * self.zoomScale > imageViewSize.height ? (newHeight - imageViewSize.height) : (self.frame.height - self.contentSize.height))
                
                self.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
//            }
        } else {
            self.contentInset = .zero
        }
    }
    
    func handleZoomOnDoubleClick(at center: CGPoint, size: CGSize, newCenter: CGPoint) {
        if self.zoomScale == 1 {
            self.zoom(to: zoomRectForScale(scale: self.maximumZoomScale, center: center, size: size, newCenter: newCenter), animated: true)
        } else {
            self.setZoomScale(1, animated: true)
        }
    }

    func zoomRectForScale(scale: CGFloat, center: CGPoint, size: CGSize, newCenter: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = size.height / scale
        zoomRect.size.width  = size.width / scale
        let newCenter = newCenter
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
}
