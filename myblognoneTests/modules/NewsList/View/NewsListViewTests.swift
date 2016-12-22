//
//  NewsListViewTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class NewsListViewTests: XCTestCase {
    
    private var view: NewsListViewController!
    private var mockPresenter: MockNewsListPresenter!
    
    override func setUp() {
        super.setUp()
        
        view = UIStoryboard(name: "NewsList", bundle: Bundle.main).instantiateViewController(withIdentifier: NewsListWireFrame.NewsListViewControllerIdentifier) as! NewsListViewController
        mockPresenter = MockNewsListPresenter()
        view.presenter = mockPresenter
        let _ = view.view
    }
    
    func testTitleForView() {
        XCTAssertEqual(view.title, NSLocalizedString("app_name_text", comment: ""), "Title should be \(NSLocalizedString("app_name_text", comment: "")).")
    }
    
    func testNewsTableViewIsNotNil() {
        XCTAssertNotNil(view.newsTableView, "NewsTableView should not be nil.")
    }
    
    func testTableFooterViewForNewsTableView() {
        XCTAssertEqual(view.newsTableView.tableFooterView?.frame, CGRect(x: 0, y: 0, width: 375, height: 0), "TableFooterView's frame for newsTableView shoul be zero (except width).")
    }
    
    func testProgressViewIsShownBeforeRequestPresenter() {
        XCTAssertTrue(ProgressView.shared.isShown(), "ProgressView should be shown.")
    }
    
    func testProgressViewIsHiddenAfterReceiveDataFromPresentorSuccessful() {
        view.updateNewsTableView(newsList: [News]())
        XCTAssertFalse(ProgressView.shared.isShown(), "ProgressView should be hidden.")
    }
    
    func testProgressViewIsHiddenAfterReceiveDataFromPresentorFail() {
        view.showErrorMessage(message: "")
        XCTAssertFalse(ProgressView.shared.isShown(), "ProgressView should be hidden.")
    }
    
    func testViewDidLoadRequestNewsFeedData() {
        XCTAssertTrue(mockPresenter.isRequestedNewsFeedData, "didRequestNewsFeedData should be called.")
    }
    
    func testUpdateNewsTableView() {
        // Given
        var newsList = [News]()
        newsList.append(News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil))
        
        // When
        view.updateNewsTableView(newsList: newsList)
        
        // Then
        XCTAssertEqual(view.newsTableView.numberOfRows(inSection: 0), 1, "Number of cells in newsTableView should be 1.")
    }
    
    func testRegisterReuseIdentifierForNewsTableView() {
        let news = News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil)
        view.updateNewsTableView(newsList: [news])
        
        let cell = view.newsTableView.cellForRow(at: IndexPath(item: 0, section: 0))
        XCTAssertTrue(cell is NewsListTableViewCell, "Cell should be \"NewsListTableViewCell\".")
    }
    
    func testNumberOfRowsInSectionForNewsTableViewInCaseOfNilDataSource() {
        XCTAssertEqual(view.newsTableView.numberOfRows(inSection: 0), 0, "Number of rows should be 0.")
    }
    
    func testDidSelectNewsTableView() {
        // Given
        var newsList = [News]()
        newsList.append(News(title: "title", link: nil, detail: nil, pubDate: nil, creator: nil))
        newsList.append(News(title: "title2", link: nil, detail: nil, pubDate: nil, creator: nil))
        
        // When
        view.updateNewsTableView(newsList: newsList)
        view.tableView(view.newsTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        // Then
        XCTAssertEqual(mockPresenter.news?.title, "title", "News title should be \"title\".")
    }
    
    func testHeightOfNewsListCell() {
        let news = News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil)
        view.updateNewsTableView(newsList: [news])
        
        let cellHeight = view.tableView(view.newsTableView, heightForRowAt: IndexPath(item: 0, section: 0))
        XCTAssertEqual(cellHeight, NewsListTableViewCell.cellHeight, "Height of cell should be equal \(NewsListTableViewCell.cellHeight)")
    }
    
    func testAllOfElementsInNewsListTableViewCellAreLoaded() {
        let news = News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil)
        view.updateNewsTableView(newsList: [news])
        let cell = view.newsTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! NewsListTableViewCell
        
        XCTAssertNotNil(cell.titleLabel, "Title label should not be nil.")
        XCTAssertNotNil(cell.detailLabel, "Detail label should not be nil.")
        XCTAssertNotNil(cell.dateTimeLabel, "DateTime label should not be nil.")
    }
    
    func testAllOfElementsInNewsListTableViewCellAreSetToNews() {
        let news = News(title: "title", link: nil, detail: "detail", pubDate: "datetime", creator: nil)
        view.updateNewsTableView(newsList: [news])
        let cell = view.newsTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! NewsListTableViewCell
        
        XCTAssertEqual(cell.titleLabel.text, news.title, "Title label should be set.")
        XCTAssertEqual(cell.detailLabel.text, news.detail, "Detail label should be set.")
        XCTAssertEqual(cell.dateTimeLabel.text, news.pubDate, "DateTime label should be set.")
    }
    
    override func tearDown() {
        view = nil
        mockPresenter = nil
        
        super.tearDown()
    }

}

private class MockNewsListPresenter: NewsListPresenterProtocol, NewsListInteractorOutputProtocol {
    
    var view: NewsListViewProtocol?
    var interactor: NewsListInteractorInputProtocol?
    var wireFrame: NewsListWireFrameProtocol?
    
    var isRequestedNewsFeedData = false
    var news: News?
    
    func didRequestNewsFeedData() {
        isRequestedNewsFeedData = true
    }
    
    func didRequestNewsDetail(news: News) {
        self.news = news
    }
    
    func didReceiveNewsFeedResult(newsFeedResult: NewsListInteractor.NewsFeedResult) {
        
    }
    
}
