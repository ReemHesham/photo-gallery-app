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
    
    @IBOutlet weak var ownerNameLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    static let cellId = "PhotoCollectionViewCell"
    
    func configure(_ url: String, ownerName: String) {
        ownerNameLabel.text = ownerName
        guard let url = URL(string: url) else {
            return
        }
        photoImage.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "Placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
    }
}
