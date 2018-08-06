//
//  PhotoDetailsViewModel.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/28/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

class PhotoDetailsViewModel {
    
    var photo: Photo?
    
    init(_ photo: Photo) {
        self.photo = photo
    }

    func getPhotoUrl() -> URL? {
        guard let urlString = photo?.getPhotoSmallUrl(), let url = URL(string: urlString) else {
            return nil
        }
        return url
    }
    
    func getPhotoOwnerName() -> String {
        return photo?.getOwnerName() ?? ""
    }
}
