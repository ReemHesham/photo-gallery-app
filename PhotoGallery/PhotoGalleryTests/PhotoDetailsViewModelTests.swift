//
//  PhotoDetailsViewModelTests.swift
//  PhotoGalleryTests
//
//  Created by reem hesham on 8/5/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import XCTest
@testable import PhotoGallery

class PhotoDetailsViewModelTests: XCTestCase {
    var photo: Photo!
    override func setUp() {
        super.setUp()
        let photoURLs = PhotoUrls(raw: "", full: "https://images.unsplash.com/photo-1532800621406-0280a106eaa6?ixlib=rb-0.3.5&q=85&fm=jpg&crop=entropy&cs=srgb&ixid=eyJhcHBfaWQiOjMyNTM1fQ&s=36fa31d4170506c89b71fbeb6e092224", regular: "", small: "https://images.unsplash.com/photo-1532800621406-0280a106eaa6?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjMyNTM1fQ&s=fd97ef8d5c741fbc9c13a2fdc9ccfba8", thumb: "")
        let userProfileImage = UserProfileImage(small: "", medium: "", large: "")
        photo = Photo(id: "w8_IxV1G_EI", createdAt: "", updatedAt: "", width: 3537, height: 5305, photoDescription: nil, color: "#101215", urls: photoURLs, likes: 62, user: User(id: "hBgQPSnsIPY", username: "joaosilas", name: "João Silas", portfolioUrl: nil, profileImage: userProfileImage, totalPhotos: 219, totalLiks: 3))
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testPhotoDetailsViewModel() {
        let viewModel = PhotoDetailsViewModel(photo)
        XCTAssertNotNil(viewModel)
        XCTAssertEqual(viewModel.getPhotoOwnerName(), "João Silas", "Owner name: \(viewModel.getPhotoOwnerName())")
    }
    
}
