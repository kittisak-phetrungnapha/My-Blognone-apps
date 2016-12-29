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
    
    func testPushToNewsDetailInterfaceWithInvalidLink() {
        // Given
        let expectErrorMessage = NSLocalizedString("invalid_news_link_error_text", comment: "")
        
        // When
        let news = News(title: "", link: "", detail: "", pubDate: "", creator: "")
        presenter.didRequestNewsDetail(news: news)
        
        // Then
        XCTAssertEqual(mockView.message, expectErrorMessage, "NewsListView should show error message.")
    }
    
    func testPushToNewsDetailInterfaceWithValidLink() {
        let news = News(title: "", link: "https://www.facebook.com/", detail: "", pubDate: "", creator: "")
        presenter.didRequestNewsDetail(news: news)
        XCTAssertTrue(mockWireframe.willCallUpdateNewsTableView, "UpdateNewsTableView should be called.")
    }
    
    func testPushToAboutInterface() {
        // Given
        let nav = UINavigationController()
        
        // When
        presenter.requestOpeningAboutPage(fromView: nav)
        
        // Then
        XCTAssertTrue(mockWireframe.willCallPushToAboutInterface, "PushToAboutInterface should be called.")
    }
    
    func testUpdateNewsTableView() {
        // Given
        var newsList = [News]()
        for _ in 0..<2 {
            let news = News(title: "", link: "", detail: "", pubDate: "", creator: "")
            newsList.append(news)
        }
        let successResult = NewsListInteractor.NewsFeedResult.success(newsList)
        
        // When
        presenter.didReceiveNewsFeedResult(newsFeedResult: successResult)
        
        // Then
        XCTAssertEqual(mockView.tableView.numberOfRows(inSection: 0), 2, "TableView should has 2 cells.")
    }
    
    func testShowErrorMessage() {
        // Given
        let errorResult = NewsListInteractor.NewsFeedResult.error("Dummy error")
        
        // When
        presenter.didReceiveNewsFeedResult(newsFeedResult: errorResult)
        
        // Then
        XCTAssertEqual(mockView.message, "Dummy error", "Error message should be equal \"Dummy error\".")
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
    
    var willCallUpdateNewsTableView = false
    var willCallShowErrorMessage = false
    var willCallPushToAboutInterface = false
    
    static func setNewsListInterface(to window: AnyObject) {
        
    }
    
    func pushToNewsDetailInterface(news: News, viewController: AnyObject?) {
        guard let _ = URL(string: news.link) else { return }
        
        willCallUpdateNewsTableView = true
    }
    
    func pushToAboutInterface(fromView view: AnyObject) {
        willCallPushToAboutInterface = true
    }
    
}

private class MockViewController: NewsListViewProtocol {
    
    var presenter: NewsListPresenterProtocol?
    var newsList: [News]?
    var message: String?
    
    var tableView: UITableView!
    var dataSource: FakeDataSource!
    
    init() {
        tableView = UITableView(frame: .zero, style: .plain)
        dataSource = FakeDataSource()
        tableView.dataSource = dataSource
    }
    
    func updateNewsTableView(newsList: [News]) {
        self.newsList = newsList
        dataSource.setupItemsForDataSource(newsList: newsList)
        tableView.reloadData()
    }
    
    func showErrorMessage(message: String) {
        self.message = message
    }
    
    class FakeDataSource: NSObject, UITableViewDataSource {
        
        private var newsList: [News]?
        
        func setupItemsForDataSource(newsList: [News]) {
            self.newsList = newsList
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return newsList?.count ?? 0
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
        
    }
    
}
