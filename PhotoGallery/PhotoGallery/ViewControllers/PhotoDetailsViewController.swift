//
//  PhotoDetailsViewController.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/28/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoDetailsViewController: UIViewController {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var photoDetailsViewModel: PhotoDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 6.0
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGest)
        photoImage.kf.setImage(with: photoDetailsViewModel?.getPhotoUrl(), placeholder: #imageLiteral(resourceName: "Placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func config(_ viewModel: PhotoDetailsViewModel) {
        photoDetailsViewModel = viewModel
    }

    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if scrollView.zoomScale == 1 {
            scrollView.zoom(to: zoomRectForScale(scale: scrollView.maximumZoomScale, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            scrollView.setZoomScale(1, animated: true)
        }
    }

    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = photoImage.frame.size.height / scale
        zoomRect.size.width  = photoImage.frame.size.width  / scale
        let newCenter = photoImage.convert(center, from: scrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
}
extension PhotoDetailsViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImage
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            
            if let image = photoImage.image {
                
                let ratioW = photoImage.frame.width / image.size.width
                let ratioH = photoImage.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW:ratioH
                
                let newWidth = image.size.width*ratio
                let newHeight = image.size.height*ratio
                
                let left = 0.5 * (newWidth * scrollView.zoomScale > photoImage.frame.width ? (newWidth - photoImage.frame.width) : (scrollView.frame.width - scrollView.contentSize.width))
                let top = 0.5 * (newHeight * scrollView.zoomScale > photoImage.frame.height ? (newHeight - photoImage.frame.height) : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsetsMake(top, left, top, left)
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
