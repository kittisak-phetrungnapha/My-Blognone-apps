//
//  AboutViewTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class AboutViewTests: XCTestCase {

    private var view: AboutViewController!
    private var mockPresentor: MockPresentor!
    
    override func setUp() {
        super.setUp()
        
        view = UIStoryboard(name: AboutWireFrame.StoryboardIdentifier, bundle: Bundle.main).instantiateViewController(withIdentifier: AboutWireFrame.AboutViewControllerIdentifier) as! AboutViewController
        mockPresentor = MockPresentor()
        view.presenter = mockPresentor
        
        let _ = view.view
    }
    
    override func tearDown() {
        view = nil
        mockPresentor = nil
        
        super.tearDown()
    }
    
    func testComponentsIsConnectedWithStoryboard() {
        XCTAssertNotNil(view.versionTitleLabel, "VersionTitleLabel should not be nil.")
        XCTAssertNotNil(view.versionValueLabel, "VersionValueLabel should not be nil.")
        XCTAssertNotNil(view.sendFeedbackTitleLabel, "SendFeedback should not be nil.")
        XCTAssertNotNil(view.rateThisAppsLabel, "RateThisAppsLabel should not be nil.")
        XCTAssertNotNil(view.sendFeedbackCell, "SendFeedbackCell should not be nil.")
        XCTAssertNotNil(view.rateCell, "RateCell should not be nil.")
    }
    
    func testTitleIsSet() {
        XCTAssertNotNil(view.title, "Title should not be nil.")
    }
    
    func testTableViewIsGroupStyle() {
        XCTAssertEqual(view.tableView.style, .grouped, "TableView should be group style.")
    }
    
    func testSelectedBackgroundViewForSendFeedbackAndRateAppsIsBlognoneGreen() {
        XCTAssertEqual(view.sendFeedbackCell.selectedBackgroundView?.backgroundColor, UIColor(hexString: UIColor.highLightNewsListCellBackground), "SelectedBackgroundView should be green.")
        
        XCTAssertEqual(view.rateCell.selectedBackgroundView?.backgroundColor, UIColor(hexString: UIColor.highLightNewsListCellBackground), "SelectedBackgroundView should be green.")
    }
    
    func testTableViewWithCorrectSections() {
        XCTAssertEqual(view.tableView.numberOfSections, 1, "TableView's section should be 1.")
    }
    
    func testTableViewHasCorrectRowsWithSection0() {
        XCTAssertEqual(view.tableView.numberOfRows(inSection: 0), 3, "TableView's first section should has 3 rows.")
    }
    
    func testTableViewIsDisableScrolled() {
        XCTAssertFalse(view.tableView.isScrollEnabled, "TableView should not be scrollable.")
    }
    
    func testVersionValueLabelIsSet() {
        let input = "1.0 (1)"
        view.setupVersionAndBuildNumber(input: input)
        XCTAssertEqual(view.versionValueLabel.text, input, "VersionValueLabel should equal 1.0 (1).")
    }
    
    func testShouldRequestSendEmailFeedback() {
        // Given
        let indexPath = IndexPath(row: 1, section: 0)
        
        // When
        view.tableView(view.tableView, didSelectRowAt: indexPath)
        
        // Then
        XCTAssertTrue(mockPresentor.isRequestSendEmailFeedback, "didRequestSendEmailFeedback should be called.")
    }
    
    func testShouldRequestRateThisApps() {
        // Given
        let indexPath = IndexPath(row: 2, section: 0)
        
        // When
        view.tableView(view.tableView, didSelectRowAt: indexPath)
        
        // Then
        XCTAssertTrue(mockPresentor.isRequestRateThisApps, "didRequestRateThisApps should be called.")
    }

}

private class MockPresentor: AboutPresenterProtocol {
    
    var view: AboutViewProtocol?
    var interactor: AboutInteractorInputProtocol?
    var wireFrame: AboutWireFrameProtocol?
    
    var isRequestSendEmailFeedback = false
    var isRequestRateThisApps = false
    
    func didRequestSendEmailFeedback() {
        isRequestSendEmailFeedback = true
    }
    
    func didRequestRateThisApps() {
        isRequestRateThisApps = true
    }
    
    func didRequestVersionAndBuildNumber() {
        
    }
    
}
