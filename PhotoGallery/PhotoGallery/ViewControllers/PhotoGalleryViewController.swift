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
    
    var photosViewModel: PhotosViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        photosViewModel = PhotosViewModel(self)
        photosViewModel?.getPhotos()
        collectionView.register(UINib(nibName: PhotoCollectionViewCell.cellId, bundle: nil), forCellWithReuseIdentifier: PhotoCollectionViewCell.cellId)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        return cell
    }
}

extension PhotoGalleryViewController: PhotoGalleryDelegate {
    func updateUI() {
        collectionView.reloadData()
    }
    
    func updateUI(with error: String) {
        
    }
}
