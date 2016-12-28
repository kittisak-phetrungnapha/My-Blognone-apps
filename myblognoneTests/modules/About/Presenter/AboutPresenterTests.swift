//
//  AboutPresenterTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class AboutPresenterTest: XCTestCase {
    
    private var presenter: AboutPresenter!
    private var mockView: MockViewController!
    private var mockInteractor: MockInteractor!
    private var mockWireframe: MockWireframe!
    
    override func setUp() {
        super.setUp()
        
        presenter = AboutPresenter()
        mockView = MockViewController()
        mockInteractor = MockInteractor()
        mockWireframe = MockWireframe()
        
        presenter.interactor = mockInteractor
        presenter.view = mockView
        presenter.wireFrame = mockWireframe
    }
    
    override func tearDown() {
        presenter = nil
        mockView = nil
        mockInteractor = nil
        mockWireframe = nil
        
        super.tearDown()
    }
    
    func testFoundVersionAndBuildNumber() {
        // Given
        let outputFromInteractor = "1.0 (1)"
        
        // When
        presenter.didReceiveVersionAndBuildNumber(input: outputFromInteractor)
        
        // Then
        XCTAssertEqual(mockView.versionValueLabel.text, outputFromInteractor, "VersionValueLabel should equal outputFromInteractor.")
    }
    
}

private class MockInteractor: AboutInteractorInputProtocol {
    
    var presenter: AboutInteractorOutputProtocol?
    var dataManager: AboutDataManagerInputProtocol?
    
    func requestVersionAndBuildNumber() {
        
    }
    
}

private class MockWireframe: AboutWireFrameProtocol {
    
    static func presentAboutModule(fromView view: AnyObject) {
        
    }
    
    func openMailApp() {
        
    }
    
    func openAppStore() {
        
    }
    
}

private class MockViewController: AboutViewProtocol {
    
    var presenter: AboutPresenterProtocol?
    
    var versionValueLabel: UILabel!
    
    init() {
        versionValueLabel = UILabel()
    }
    
    func setupVersionAndBuildNumber(input: String) {
        versionValueLabel.text = input
    }
    
    func showErrorMessage(message: String) {
        MyAlertView.shared.showWithTitle(title: "Wroops", message: message)
    }
    
}
