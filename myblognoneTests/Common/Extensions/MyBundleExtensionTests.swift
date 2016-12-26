//
//  MyBundleExtensionTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/26/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class MyBundleExtensionTests: XCTestCase {

    func testGetReleaseVersionNumber() {
        XCTAssertNotNil(Bundle.main.releaseVersionNumber, "ReleaseVersionNumber should not be nil.")
        
        let expectVersionNumber = "1.0"
        XCTAssertEqual(Bundle.main.releaseVersionNumber, expectVersionNumber, "ReleaseVersionNumber should be 1.0")
    }
    
    func testGetBuildVersionNumber() {
        XCTAssertNotNil(Bundle.main.buildVersionNumber, "BuildVersionNumber should not be nil.")
        
        let expectBuildNumber = "1"
        XCTAssertEqual(Bundle.main.buildVersionNumber, expectBuildNumber, "BuildVersionNumber should be 1")
    }
    
}
