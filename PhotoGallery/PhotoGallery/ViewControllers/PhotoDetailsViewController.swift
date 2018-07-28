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
    
    var photoDetailsViewModel: PhotoDetailsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        photoImage.kf.setImage(with: photoDetailsViewModel?.getPhotoUrl(), placeholder: #imageLiteral(resourceName: "Placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func config(_ viewModel: PhotoDetailsViewModel) {
        photoDetailsViewModel = viewModel
    }
    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
