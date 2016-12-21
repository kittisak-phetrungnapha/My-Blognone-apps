//
//  ProgressViewTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/21/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class ProgressViewTests: XCTestCase {
    
    private var progressView: ProgressView!
    
    override func setUp() {
        super.setUp()
        progressView = ProgressView.shared
    }
    
    override func tearDown() {
        progressView = nil
        super.tearDown()
    }
    
    func testShowProgressView() {
        progressView.hide()
        progressView.show()
        XCTAssertTrue(progressView.isShown(), "ProgressView should be shown.")
    }
    
    func testHideProgressView() {
        progressView.show()
        progressView.hide()
        XCTAssertFalse(progressView.isShown(), "ProgressView should be hidden.")
    }
    
}
