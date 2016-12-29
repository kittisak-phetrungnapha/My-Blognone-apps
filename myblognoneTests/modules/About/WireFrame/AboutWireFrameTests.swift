//
//  AboutWireFrameTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class AboutWireframeTests: XCTestCase {
    
    func testPresentAboutModule() {
        // Given
        let nav = UINavigationController()
        
        // When
        AboutWireFrame.presentAboutModule(fromView: nav)
        
        // Then
        XCTAssertTrue(nav.viewControllers[0] is AboutViewController, "AboutViewController should be presented.")
    }
    
}
