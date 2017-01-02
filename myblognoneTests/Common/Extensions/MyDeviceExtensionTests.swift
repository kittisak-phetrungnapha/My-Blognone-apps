//
//  MyDeviceExtensionTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 1/2/2560 BE.
//  Copyright © 2560 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class MyDeviceExtensionTests: XCTestCase {
    
    func testDeviceIsIPhone() {
        if UIScreen.main.traitCollection.userInterfaceIdiom == .phone { // Test on an iPhone only.
            XCTAssert(UIDevice.isIPhone(), "This device is iPad.")
            XCTAssertFalse(UIDevice.isIPad(), "This device is iPad.")
        }
    }
    
    func testDeviceIsIPad() {
        if UIScreen.main.traitCollection.userInterfaceIdiom == .pad { // Test on an iPad only.
            XCTAssertFalse(UIDevice.isIPhone(), "This device is iPhone.")
            XCTAssert(UIDevice.isIPad(), "This device is iPhone.")
        }
    }
    
}
