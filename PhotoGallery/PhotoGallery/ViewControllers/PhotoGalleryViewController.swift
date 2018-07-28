//
//  PhotoGalleryViewController.swift
//  PhotoGallery
//
//  Created by reem hesham on 7/27/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import UIKit

class PhotoGalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var loadingView: UIView!

    var photosViewModel: PhotosViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosViewModel = PhotosViewModel(self)
        startLoading()
        photosViewModel?.getPhotos()
        collectionView.register(UINib(nibName: PhotoCollectionViewCell.cellId, bundle: nil), forCellWithReuseIdentifier: PhotoCollectionViewCell.cellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func startLoading() {
        loadingView.isHidden = false
    }

    func stopLoading() {
        loadingView.isHidden = true
    }
}

extension PhotoGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = photosViewModel else {
            return 1
        }
        return viewModel.getPhotosCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCollectionViewCell.cellId, for: indexPath) as? PhotoCollectionViewCell, let viewModel = photosViewModel else {
            return UICollectionViewCell()
        }
        cell.config(viewModel.getPhotoUrl(at: indexPath.row))
        return cell
    }
}

extension PhotoGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let viewModel = photosViewModel, indexPath.row == viewModel.getPhotosCount() - 8, !viewModel.isPendingResponse else {
            return
        }
        viewModel.getPhotos()
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        <#code#>
    }
}

extension PhotoGalleryViewController: PhotoGalleryDelegate {
    func updateUI() {
        stopLoading()
        collectionView.reloadData()
    }
    
    func updateUI(with error: String) {
        
    }
}
