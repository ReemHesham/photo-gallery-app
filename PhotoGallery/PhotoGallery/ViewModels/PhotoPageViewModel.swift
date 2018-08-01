//
//  PhotoPageViewModel.swift
//  PhotoGallery
//
//  Created by reem hesham on 8/1/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

class PhotoPageViewModel {
    var photos: [Photo]
    var initialIndex: Int
    
    init(_ photos: [Photo], index: Int) {
        self.photos = photos
        self.initialIndex = index
    }
    
    func getPhotosCount() -> Int {
        return photos.count
    }
    
    func createPhotoDetailsViewModel(for index: Int) -> PhotoDetailsViewModel {
        return PhotoDetailsViewModel(photos[index])
    }

    func indexOfViewController(with viewModel: PhotoDetailsViewModel) -> Int {
        guard let photo = viewModel.photo, let index = photos.index(of: photo) else {
            fatalError("Photo is not found")
        }
        return index
    }
}
