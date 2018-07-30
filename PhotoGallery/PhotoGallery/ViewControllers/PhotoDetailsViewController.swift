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

        photoImage.kf.setImage(with: photoDetailsViewModel?.getPhotoUrl(), placeholder: #imageLiteral(resourceName: "Placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func config(_ viewModel: PhotoDetailsViewModel) {
        photoDetailsViewModel = viewModel
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
