//
//  AlbumViewModelTests.swift
//  SwifterviewingTests
//
//  Created by SOWJI on 01/08/21.
//  Copyright © 2021 World Wide Technology Application Services. All rights reserved.
//

import XCTest
@testable import Swifterviewing

class AlbumViewModelTests: XCTestCase {
    
    var viewModel: AlbumViewModel?
    override func setUpWithError() throws {
        viewModel = .init()
        try? super.setUpWithError()
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        try? super.tearDownWithError()
    }
    
    // MARK: TESTS
    func test_fetchData() {
        let expectation = XCTestExpectation(description: "Fetch Data")
        viewModel?.fetchData(callback: { error in
            XCTAssertNotNil(self.viewModel?.albums)
            XCTAssertNotNil(self.viewModel?.albums)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
}
