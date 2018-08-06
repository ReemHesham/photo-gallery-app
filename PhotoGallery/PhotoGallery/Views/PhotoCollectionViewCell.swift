//
//  PhotoCollectionViewCell.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/28/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoImage: UIImageView!
    static let cellId = "PhotoCollectionViewCell"
    
    func config(_ url: String) {
        guard let url = URL(string: url) else {
            return
        }
        photoImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "Placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
    }
}
