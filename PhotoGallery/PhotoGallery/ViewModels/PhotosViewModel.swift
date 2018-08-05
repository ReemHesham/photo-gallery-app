
//
//  PhotosViewModel.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/28/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import Foundation

protocol PhotoGalleryDelegate: class {
    func updateUI()
    func updateUI(with error: String)
}

class PhotosViewModel {
    private var photos = [Photo]()
    private var pageNumber = 1
    var isPendingResponse = false
    weak var delegate: PhotoGalleryDelegate?

    init(_ delegate: PhotoGalleryDelegate) {
        self.delegate = delegate
    }
    
    func getPhotos() {
        isPendingResponse = true
        if Utilities.isConnectedToNetwork() {
            APIClient().getPhotos(pageNumber) { (data, error) in
                if let photos = data {
                    self.photos += photos
                    self.pageNumber += 1
                    self.isPendingResponse = false
                    self.delegate?.updateUI()
                } else if let error = error {
                    self.delegate?.updateUI(with: error)
                }
            }
        } else {
            delegate?.updateUI(with: Errors.noInternetConnection)
        }
    }

    func getPhotosCount() -> Int {
        return photos.count
    }

    func getPhotoUrl(at index: Int) -> String {
        return photos[index].getPhotoSmallUrl()
    }

    func getPhotoOwnerName(at index: Int) -> String {
        return photos[index].getOwnerName()
    }
    
    func getPhotoSizeRatio(at index: Int) -> Float {
        return  Float(photos[index].height)/Float(photos[index].width)
    }
    
    func createPhotoDetailsPageViewModel(at index: Int) -> PhotoPageViewModel {
        return PhotoPageViewModel(photos, index: index)
    }
}
