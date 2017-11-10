//
//  NewsDetailUITests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/31/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest

class NewsDetailUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        XCUIDevice.shared.orientation = .portrait
        
        let table = app.tables.element
        waitForElementToAppear(element: table.cells.element)
        table.cells.element(boundBy: 0).tap()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testCloseAndOpenReaderModeAgainIfAvailable() {
        let readerButton = app.buttons["Reader"]
        if readerButton.exists {
            readerButton.tap()
            readerButton.tap()
        }
    }
    
    func testShareThenCancelIts() {
        let shareButton = app.toolbars.buttons["Share"]
        shareButton.tap()
        let cancelButton = app.buttons["Cancel"]
        waitForElementToAppear(element: cancelButton)
        XCTAssert(cancelButton.exists, "cancelButton should exist.")
        
        cancelButton.tap()
        waitForElementToDisAppear(element: cancelButton)
        
        snapshot("01NewsDetailScreen")
        
        XCTAssertFalse(cancelButton.exists, "cancelButton should not exist.")
    }
    
    func testShareFacebookOnlySimulator() {
        if TARGET_OS_SIMULATOR == 0 {
            XCTAssert(true)
            return
        }
        
        let shareButton = app.toolbars.buttons["Share"]
        shareButton.tap()
        let collectionViewsQuery = app.collectionViews
        let facebookButton = collectionViewsQuery.buttons["Facebook"]
        waitForElementToAppear(element: facebookButton)
        XCTAssert(facebookButton.exists, "Facebook button should exist.")
        
        facebookButton.tap()
        let alert = app.alerts["No Facebook Account"]
        waitForElementToAppear(element: alert)
        XCTAssert(alert.exists, "Alert should exist.")
        
        alert.buttons["Cancel"].tap() // Test user presses cancel button.
        XCTAssertFalse(alert.exists, "Alert should not exist.")
        
        // Test user presses settings button.
        shareButton.tap()
        facebookButton.tap()
        
        let settings = alert.buttons["Settings"]
        waitForElementToAppear(element: settings)
        XCTAssert(settings.exists, "Settings button should exist.")
        settings.tap()
    }
    
    func testShareFacebookOnlyRealDevice() {
        if TARGET_OS_SIMULATOR != 0 {
            XCTAssert(true)
            return
        }
        
        let shareButton = app.toolbars.buttons["Share"]
        shareButton.tap()
        let collectionViewsQuery = app.collectionViews
        collectionViewsQuery.buttons["Mail"].swipeLeft()
        let facebookButton = collectionViewsQuery.buttons["Facebook"]
        XCTAssert(facebookButton.exists, "Facebook button should be exist.")
        
        // Cancel button will be pressed at the first.
        facebookButton.tap()
        let facebookShareView = app.navigationBars["Facebook"]
        waitForElementToAppear(element: facebookShareView)
        XCTAssert(facebookShareView.exists, "Facebook share view should appear.")
        
        facebookShareView.buttons["Cancel"].tap()
        app.sheets.buttons["Discard"].tap()
        
        // Test share to facebook.
        waitForElementToAppear(element: shareButton)
        XCTAssert(shareButton.exists, "Share button should appear.")
        
        shareButton.tap()
        collectionViewsQuery.buttons["Mail"].swipeLeft()
        XCTAssert(facebookButton.exists, "Facebook button should be exist.")
        
        facebookButton.tap()
        waitForElementToAppear(element: facebookShareView)
        XCTAssert(facebookShareView.exists, "Facebook share view should appear.")
        
        let facebookTextViewToShare = app.textViews["Say something ..."]
        XCTAssert(facebookTextViewToShare.exists, "Say something... should appear.")
        
        snapshot("02NewsDetailScreen")
        
        facebookTextViewToShare.typeText("I am trying iOS Unit+UI Automation Testing with Facebook build-in SDK on iPhone 6. I really sorry if this post makes you are annoyed.")
        facebookShareView.buttons["Post"].tap()
        
        waitForElementToDisAppear(element: facebookShareView)
        XCTAssertFalse(facebookShareView.exists, "Facebook share view should be dismissed.")
    }
    
    func testOpenNewsOnSafariApp() {
        let openSafariButton = app.toolbars.buttons["Open in Safari"]
        waitForElementToAppear(element: openSafariButton)
        XCTAssert(openSafariButton.exists, "openSafariButton should appear.")
        
        openSafariButton.tap()
    }
    
}
