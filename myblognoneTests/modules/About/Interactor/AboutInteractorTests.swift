//
//  AboutInteractorTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class AboutInteractorTests: XCTestCase {

    private var interactor: AboutInteractor!
    private var mockPresentor: MockPresenter!
    private var mockDataManager: MockDataManager!
    
    override func setUp() {
        super.setUp()
        
        interactor = AboutInteractor()
        mockPresentor = MockPresenter()
        mockDataManager = MockDataManager()
        
        interactor.presenter = mockPresentor
        interactor.dataManager = mockDataManager
    }

    override func tearDown() {
        interactor = nil
        mockPresentor = nil
        mockDataManager = nil
        
        super.tearDown()
    }
    
    func testGetReleaseVersionNumber() {
        let expect = "1.0"
        let output = interactor.dataManager?.getReleaseVersionNumber()
        XCTAssertEqual(output, expect, "ReleaseVersionNumber should be equal \(expect).")
    }
    
    func getBuildVersionNumber() {
        let expect = "1"
        let output = interactor.dataManager?.getBuildVersionNumber()
        XCTAssertEqual(output, expect, "BuildVersionNumber should be equal \(expect).")
    }
 
    func testRequestVersionAndBuildNumber() {
        // Given
        let dataWillReturn = "1.0 (1)"
        
        // When
        interactor.requestVersionAndBuildNumber()
        
        // Then
        XCTAssertEqual(mockPresentor.input, dataWillReturn, "Output to presentor should equal dataWillReturn.")
    }
    
}

private class MockPresenter: AboutPresenterProtocol, AboutInteractorOutputProtocol {
    var view: AboutViewProtocol?
    var interactor: AboutInteractorInputProtocol?
    var wireFrame: AboutWireFrameProtocol?
    
    var input: String?
    
    func didRequestVersionAndBuildNumber() {
        
    }
    
    func didReceiveVersionAndBuildNumber(input: String) {
        self.input = input
    }
    
    func didRequestSendEmailFeedback() {
        
    }
    
    func didRequestRateThisApps() {
        
    }
    
}

private class MockDataManager: AboutDataManagerInputProtocol {
    
    func getReleaseVersionNumber() -> String {
        return "1.0"
    }
    
    func getBuildVersionNumber() -> String {
        return "1"
    }
    
}
