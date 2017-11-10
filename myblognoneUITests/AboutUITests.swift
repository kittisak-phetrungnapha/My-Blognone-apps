//
//  AboutUITests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 1/1/2560 BE.
//  Copyright © 2560 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest

class AboutUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        XCUIDevice.shared.orientation = .portrait
        
        app.buttons[NSLocalizedString("goToAboutNavButton", comment: "")].tap()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testOpenMailForSendFeedback() {
        let table = app.tables.element
        waitForElementToAppear(element: table.cells.element)
        
        snapshot("01AboutScreen")
        
        table.cells.element(boundBy: 1).tap()
    }
    
    func testOpenAppStoreForRateApp() {
        let table = app.tables.element
        waitForElementToAppear(element: table.cells.element)
        table.cells.element(boundBy: 2).tap()
    }
    
}
