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
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAlbumWithoutE(){
        let bundle = Bundle(for: type(of: self))

        guard let url = bundle.url(forResource: "AlbumMock", withExtension: "json") else {
            XCTFail("Missing file: User.json")
            return
        }
        
        do {
            let json = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let albums = try decoder.decode([Album].self, from: json)
            
            XCTAssertNotEqual(albums.first?.title, "hello world")            
            XCTAssertEqual(albums.first?.title, "hllo world")
            XCTAssertEqual(albums.last?.title, "hallo world")
            
        } catch {
            XCTFail("Error in decoding: \(error)")
        }
    }
    
}
