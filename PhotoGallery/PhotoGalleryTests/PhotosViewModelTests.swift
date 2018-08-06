//
//  PhotosViewModelTests.swift
//  PhotoGalleryTests
//
//  Created by reem hesham on 8/5/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import XCTest
@testable import PhotoGallery

class PhotosViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetPhotosFromAPI() {
        let apiClient = APIClient()
        
        let asyncApiCallExpectation = self.expectation(description: "asyncApiCallExpectation")
        
        apiClient.getPhotos(1) { (photos, error) in
            XCTAssertNotNil(photos)
            XCTAssertEqual(photos?.count, 30, "Total number of photos = \(String(describing: photos?.count))")
            
            XCTAssertNil(error)
            
            asyncApiCallExpectation.fulfill()
        }
        
        self.waitForExpectations(timeout: 20) { (error) in
            XCTAssertNil(error)
        }
    }
    
}
