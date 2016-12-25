//
//  MyColorExtensionTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class MyColorExtensionTests: XCTestCase {

    func testRGB12bit() {
        XCTAssertNotNil(UIColor(hexString: "#fff"), "Color should not be nil.")
        XCTAssertNotNil(UIColor(hexString: "fff"), "Color should not be nil.")
    }
    
    func testRGB24bit() {
        XCTAssertNotNil(UIColor(hexString: "#ffffff"), "Color should not be nil.")
        XCTAssertNotNil(UIColor(hexString: "ffffff"), "Color should not be nil.")
    }
    
    func testARGB32bit() {
        XCTAssertNotNil(UIColor(hexString: "#ffffff00"), "Color should not be nil.")
        XCTAssertNotNil(UIColor(hexString: "ffffff00"), "Color should not be nil.")
    }
    
    func testInvalidInputs() {
        XCTAssertNil(UIColor(hexString: ""), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "#"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "-1"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "a"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "*"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "~"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "|"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "ก"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "12"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "#12"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "1234"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "#1234"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "1234560"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "#1234560"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "1234512345"), "Color should be nil.")
        XCTAssertNil(UIColor(hexString: "#1234512345"), "Color should be nil.")
    }
    
}
