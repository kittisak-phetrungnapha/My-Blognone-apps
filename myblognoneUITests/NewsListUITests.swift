//
//  myblognoneUITests.swift
//  myblognoneUITests
//
//  Created by Kittisak Phetrungnapha on 12/30/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest

class NewsListUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        XCUIDevice.shared().orientation = .portrait
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    func testAllElementsAreExist() {
        XCTAssert(app.tables.element.exists)
        XCTAssert(app.navigationBars["My Blognone"].exists)
        XCTAssert(app.buttons[NSLocalizedString("goToAboutNavButton", comment: "")].exists)
        
        snapshot("01NewsListScreen")
    }
    
    func testScrollTableView() {
        let table = app.tables.element
        waitForElementToAppear(element: table.cells.element)
        
        let lastCell = table.cells.element(boundBy: table.cells.count - 1)
        table.scrollDownToElement(element: lastCell)
        XCTAssert(lastCell.visible(), "TableView should be scrolled to last cell.")
        
        let firstCell = table.cells.element(boundBy: 0)
        table.scrollUpToElement(element: firstCell)
        XCTAssert(firstCell.visible(), "TableView should be scrolled to first cell.")
    }
    
    func testPullToRefreshTableView() {
        let table = app.tables.element
        waitForElementToAppear(element: table.cells.element)
        
        let firstCell = table.cells.element(boundBy: 0)
        let start = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 0))
        let finish = firstCell.coordinate(withNormalizedOffset: CGVector(dx: 0, dy: 6))
        start.press(forDuration: 2, thenDragTo: finish)
    }
    
    func testPushAndPopWithAboutScreen() {
        app.buttons[NSLocalizedString("goToAboutNavButton", comment: "")].tap()
        XCTAssert(app.navigationBars["About"].exists)
        
        app.navigationBars.buttons.element(boundBy: 0).tap()
        XCTAssert(app.navigationBars["My Blognone"].exists)
    }
    
    func testPushAndPopWithSFViewControllerScreen() {
        let table = app.tables.element
        waitForElementToAppear(element: table.cells.element)
        
        table.cells.element(boundBy: 0).tap()
        let doneButtonInDetailScreen = app.buttons["Done"]
        waitForElementToAppear(element: doneButtonInDetailScreen)
        XCTAssert(doneButtonInDetailScreen.exists, "Done button should be exist.")
        
        doneButtonInDetailScreen.tap()
        XCTAssert(app.navigationBars["My Blognone"].exists)
    }
    
    func testScrollToLastRowThenSelectIt() {
        let table = app.tables.element
        waitForElementToAppear(element: table.cells.element)
        
        let lastCell = table.cells.element(boundBy: table.cells.count - 1)
        table.scrollDownToElement(element: lastCell)
        XCTAssert(lastCell.visible(), "TableView should be scrolled to last cell.")
        
        table.cells.element(boundBy: table.cells.count - 1).tap()
        let doneButtonInDetailScreen = app.buttons["Done"]
        waitForElementToAppear(element: doneButtonInDetailScreen)
        XCTAssert(doneButtonInDetailScreen.exists, "Done button should be exist.")
        
        doneButtonInDetailScreen.tap()
        XCTAssert(app.navigationBars["My Blognone"].exists)
    }
    
}
