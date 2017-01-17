//
//  AboutDataManagerTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/29/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class AboutDataManagerTests: XCTestCase {
    
    var dataManager: AboutDataManager!
    
    override func setUp() {
        super.setUp()
        dataManager = AboutDataManager()
    }
    
    override func tearDown() {
        dataManager = nil
        super.tearDown()
    }
    
    func testGetReleaseVersionNumber() {
        let expect = "1.0"
        let output = dataManager.getReleaseVersionNumber()
        XCTAssertEqual(output, expect, "ReleaseVersionNumber should be equal \(expect).")
    }
    
    func testGetBuildVersionNumber() {
        let expect = "2"
        let output = dataManager.getBuildVersionNumber()
        XCTAssertEqual(output, expect, "BuildVersionNumber should be equal \(expect).")
    }
    
}
