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

    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomView: UIView!
    
    var photoDetailsViewModel: PhotoDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.zoomScale = 1.0
        setupGesture()
        photoImage.kf.setImage(with: photoDetailsViewModel?.getPhotoUrl(), placeholder: #imageLiteral(resourceName: "Placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        ownerNameLabel.text = photoDetailsViewModel?.getPhotoOwnerName()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bottomView.isHidden = false
    }
    
    func config(_ viewModel: PhotoDetailsViewModel) {
        photoDetailsViewModel = viewModel
    }

    func setupGesture() {
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        scrollView.addGestureRecognizer(doubleTapGest)
    }
    
    @objc func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        let center = recognizer.location(in: recognizer.view)
        scrollView.handleZoomOnDoubleClick(at: center, size: photoImage.frame.size, newCenter: photoImage.convert(center, from: scrollView))
    }
    
    func setUpBottomView() {

        UIView.animate(withDuration: 0.23, delay: 0.0, options: .beginFromCurrentState, animations: { () -> Void in
            
            self.bottomView.isHidden = !self.bottomView.isHidden
            
        }, completion: nil)
        
    }

    func handleBottomViewAppearance(isHidden: Bool) {
        bottomView.isHidden = isHidden
    }
}
extension PhotoDetailsViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImage
    }

    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if let image = photoImage.image {
            scrollView.handleZoom(for: photoImage.frame.size, imageSize: image.size)
        }
    }
}
