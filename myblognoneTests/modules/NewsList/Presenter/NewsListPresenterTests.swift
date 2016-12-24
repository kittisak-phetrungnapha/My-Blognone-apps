//
//  NewsListPresenterTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class NewsListPresenterTest: XCTestCase {

    private var presenter: NewsListPresenter!
    private var mockInteractor: MockInteractor!
    private var mockView: MockViewController!
    private var mockWireframe: MockWireframe!
    
    override func setUp() {
        super.setUp()
        
        presenter = NewsListPresenter()
        
        mockInteractor = MockInteractor()
        mockView = MockViewController()
        mockWireframe = MockWireframe()
        
        presenter.interactor = mockInteractor
        presenter.wireFrame = mockWireframe
        presenter.view = mockView
    }
    
    override func tearDown() {
        presenter = nil
        mockInteractor = nil
        mockView = nil
        mockWireframe = nil
        
        super.tearDown()
    }
    
    func testRequestNewsFeedData() {
        presenter.didRequestNewsFeedData()
        XCTAssertTrue(mockInteractor.verifyPerformGetNewsFeedTask, "PerformGetNewsFeedTask should be called.")
    }
    
    func testPushToNewsDetailInterface() {
        let news = News(title: "", link: "", detail: "", pubDate: "", creator: "")
        presenter.wireFrame?.pushToNewsDetailInterface(news: news, viewController: mockView)
        XCTAssertNotNil(mockWireframe.news, "News should not be nil.")
    }
    
    func testUpdateNewsTableView() {
        var newsList = [News]()
        for _ in 0..<2 {
            let news = News(title: "", link: "", detail: "", pubDate: "", creator: "")
            newsList.append(news)
        }
        presenter.view?.updateNewsTableView(newsList: newsList)
        XCTAssertEqual(mockView.newsList?.count, 2, "Mock news list should has 2 elements.")
    }
    
    func testShowErrorMessage() {
        let message = "Dummy error message"
        presenter.view?.showErrorMessage(message: message)
        XCTAssertEqual(mockView.message, message, "Error message should be \"Dummy error message\".")
    }
    
}

private class MockInteractor: NewsListInteractorInputProtocol {
    
    var presenter: NewsListInteractorOutputProtocol?
    var apiDataManager: NewsListAPIDataManagerInputProtocol?
    
    var verifyPerformGetNewsFeedTask = false
    
    func performGetNewsFeedTask() {
        verifyPerformGetNewsFeedTask = true
    }
    
}

private class MockWireframe: NewsListWireFrameProtocol {
    
    var news: News?
    
    static func setNewsListInterface(to window: AnyObject) {
        
    }
    
    func pushToNewsDetailInterface(news: News, viewController: AnyObject?) {
        self.news = news
    }
    
}

private class MockViewController: NewsListViewProtocol {
    
    var presenter: NewsListPresenterProtocol?
    var newsList: [News]?
    var message: String?
    
    func updateNewsTableView(newsList: [News]) {
        self.newsList = newsList
    }
    
    func showErrorMessage(message: String) {
        self.message = message
    }
    
}
