//
//  PhotosViewModel.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/28/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

class PhotosViewModel {
    var photos: [Photo]?
    var pageNumber = 0
    
    func getPhotos() {
        APIClient().getPhotoes(pageNumber) { (data, error) in
            if let data = data as? [[String: Any]] {
                self.photos = PhotosManager.shared.parsePhotosResponse(data)
            }
        }
    }

    func getPhotosCount() -> Int {
        guard let photos = photos else {
            return 0
        }
        return photos.count
    }

    func getPhotoUrl(at index: Int) -> String {
        return photos?[index].urls?.small ?? ""
    }
}
