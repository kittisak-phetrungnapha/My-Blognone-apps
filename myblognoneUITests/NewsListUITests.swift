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
        let tableElements = app.tables.element
        let myBlognoneNavBar = app.navigationBars["My Blognone"]
        let aboutNavButton = app.buttons[NSLocalizedString("goToAboutNavButton", comment: "")]
        
        waitForElementToAppear(element: tableElements)
        waitForElementToAppear(element: myBlognoneNavBar)
        waitForElementToAppear(element: aboutNavButton)
        
        XCTAssert(tableElements.exists, "Table elements should exist.")
        XCTAssert(myBlognoneNavBar.exists, "My Blognone nav bar should exist.")
        XCTAssert(aboutNavButton.exists, "About nav button should exist.")
        
        snapshot("01NewsListScreen")
    }
    
    func testScrollTableView() {
        let table = app.tables.element
        waitForElementToAppear(element: table.cells.element)
        
        let lastCell = table.cells.element(boundBy: table.cells.count - 1)
        table.scrollDownToElement(element: lastCell)
        XCTAssert(lastCell.isHittable, "TableView should be scrolled to last cell.")
        
        let firstCell = table.cells.element(boundBy: 0)
        table.scrollUpToElement(element: firstCell)
        XCTAssert(firstCell.isHittable, "TableView should be scrolled to first cell.")
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
        let aboutNavButtonItem = app.buttons[NSLocalizedString("goToAboutNavButton", comment: "")]
        waitForElementToAppear(element: aboutNavButtonItem)
        XCTAssert(aboutNavButtonItem.exists, "About bav button should appear.")
        
        aboutNavButtonItem.tap()
        let aboutNavBar = app.navigationBars["About"]
        waitForElementToAppear(element: aboutNavBar)
        XCTAssert(aboutNavBar.exists, " About nav bar should appear.")
        
        let doneButton = aboutNavBar.buttons.element(boundBy: 0)
        waitForElementToAppear(element: doneButton)
        XCTAssert(doneButton.exists, "Done button should appear.")
        
        doneButton.tap()
        let myBlognoneNavBar = app.navigationBars["My Blognone"]
        waitForElementToAppear(element: myBlognoneNavBar)
        XCTAssert(myBlognoneNavBar.exists, "My Blognone nav bar should appear.")
    }
    
    func testPushAndPopWithSFViewControllerScreen() {
        let table = app.tables.element
        waitForElementToAppear(element: table.cells.element)
        XCTAssert(table.cells.element.exists, "Cells should appear.")
        
        table.cells.element(boundBy: 0).tap()
        let doneButtonInDetailScreen = app.buttons["Done"]
        waitForElementToAppear(element: doneButtonInDetailScreen)
        XCTAssert(doneButtonInDetailScreen.exists, "Done button should appear.")
        
        doneButtonInDetailScreen.tap()
        let myBlognoneNavBar = app.navigationBars["My Blognone"]
        waitForElementToAppear(element: myBlognoneNavBar)
        XCTAssert(myBlognoneNavBar.exists, "My Blognone nav bar should appear.")
    }
    
    func testScrollToLastRowThenSelectIt() {
        let table = app.tables.element
        waitForElementToAppear(element: table.cells.element)
        
        let lastCell = table.cells.element(boundBy: table.cells.count - 1)
        table.scrollDownToElement(element: lastCell)
        XCTAssert(lastCell.isHittable, "TableView should be scrolled to last cell.")
        
        table.cells.element(boundBy: table.cells.count - 1).tap()
        let doneButtonInDetailScreen = app.buttons["Done"]
        waitForElementToAppear(element: doneButtonInDetailScreen)
        XCTAssert(doneButtonInDetailScreen.exists, "Done button should be exist.")
        
        doneButtonInDetailScreen.tap()
        XCTAssert(app.navigationBars["My Blognone"].exists)
    }
    
}
