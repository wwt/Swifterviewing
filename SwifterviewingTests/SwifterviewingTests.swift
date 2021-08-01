//
//  SwifterviewingTests.swift
//  SwifterviewingTests
//
//  Created by Tyler Thompson on 7/9/20.
//  Copyright © 2020 World Wide Technology Application Services. All rights reserved.
//

import XCTest
@testable import Swifterviewing

class SwifterviewingTests: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
    }
    
    // MARK: API CALL TESTS
    func test_fetchAlbumData_whenAlubumDataDownloaded() {
        
        let expectation = XCTestExpectation(description: "Download albums")
        
        let api = API()
        api.getAlbums { result in
            switch result {
            case .success(let albums):
                XCTAssertNotNil(albums, "Albums data fetched")
            case .failure(_):
                XCTAssertFalse(false, "Unexpected failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_fetchAlbumData_whenEndpointIsNotThereThrowsError() {
        
        let expectation = XCTestExpectation(description: "Download albums")
        
        var api = API()
        api.albumsEndpoint = "test"
        api.getAlbums { result in
            switch result {
            case .success(_):
                XCTAssertFalse(false, "Unexpected Success")
            case .failure(let error):
                XCTAssertNotNil(error,error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_fetchPhotosData_whenPhotosDataDownloaded() {
        
        let expectation = XCTestExpectation(description: "Throws error")
        
        let api = API()
        api.getPhotos { result in
            switch result {
            case .success(let albums):
                XCTAssertNotNil(albums, "Photos data fetched")
            case .failure(_):
                XCTAssertFalse(false, "Unexpected failure")
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_fetchPhotosData_whenEndpointIsNotThereThrowsError() {
        
        let expectation = XCTestExpectation(description: "Throws error")
        
        var api = API()
        api.photosEndpoint = "test"
        api.getPhotos { result in
            switch result {
            case .success(_):
                XCTAssertFalse(false, "Unexpected Success")
            case .failure(let error):
                XCTAssertNotNil(error,error.localizedDescription)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }
}
