//
//  PhotoGalleryTests.swift
//  PhotoGalleryTests
//
//  Created by reem hesham on 7/27/18.
//  Copyright © 2018 reem hesham. All rights reserved.
//

import XCTest
@testable import PhotoGallery

class PhotoGalleryTests: XCTestCase {
    var photos: [Photo]?
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testJSONMapping() throws {
        let bundle = Bundle(for: type(of: self))
        
        guard let url = bundle.url(forResource: "Photos", withExtension: "json") else {
            XCTFail("Missing file: Photos.json")
            return
        }
        
        let data = try Data(contentsOf: url)

        let decoder = JSONDecoder()
        do {
            photos = try decoder.decode([Photo].self, from: data)
        } catch {
            XCTFail("Faild to parse photos json")
        }
        guard let photos = photos else {
            XCTFail("Faild to parse photos json")
            return
        }
        XCTAssertNotNil(photos, "Faild to parse photos json")
        XCTAssertEqual(photos[0].id, "w8_IxV1G_EI")
        XCTAssertEqual(photos[0].urls.small, "https://images.unsplash.com/photo-1532800621406-0280a106eaa6?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=400&fit=max&ixid=eyJhcHBfaWQiOjMyNTM1fQ&s=fd97ef8d5c741fbc9c13a2fdc9ccfba8")
        XCTAssertEqual(photos[0].height, 5305, "height: \(photos[0].height)")
        XCTAssertEqual(photos[0].user.name, "João Silas", "userName: \(photos[0].user.name)")
    }
    
}
