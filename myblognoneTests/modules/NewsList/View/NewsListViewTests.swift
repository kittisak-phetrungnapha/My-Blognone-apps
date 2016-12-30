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
        
        view = UIStoryboard(name: NewsListWireFrame.StoryboardIdentifier, bundle: Bundle.main).instantiateViewController(withIdentifier: NewsListWireFrame.NewsListViewControllerIdentifier) as! NewsListViewController
        let _ = UINavigationController(rootViewController: view)
        mockPresenter = MockNewsListPresenter()
        view.presenter = mockPresenter
        let _ = view.view
    }
    
    override func tearDown() {
        view.removeFromParentViewController()
        view = nil
        mockPresenter = nil
        
        super.tearDown()
    }
    
    func testStatusBarShouldBeLightStyleWhenViewDidAppear() {
        view.viewDidAppear(true)
        XCTAssertEqual(UIApplication.shared.statusBarStyle, .lightContent, "Status bar should be light.")
    }
    
    func testTitleForView() {
        XCTAssertEqual(view.title, NSLocalizedString("app_name_text", comment: ""), "Title should be \(NSLocalizedString("app_name_text", comment: "")).")
    }
    
    func testAboutInfoNavigationItemAtRight() {
        XCTAssertNotNil(view.navigationItem.rightBarButtonItem, "About info right nav button should be added.")
        XCTAssertEqual(view.navigationItem.rightBarButtonItem?.accessibilityLabel, NSLocalizedString("go_to_about_nav_button", comment: ""))
    }
    
    func testNewsTableViewIsNotNil() {
        XCTAssertNotNil(view.newsTableView, "NewsTableView should not be nil.")
    }
    
    func testNewsTableViewIsHiddenAtInitialState() {
        XCTAssertTrue(view.newsTableView.isHidden, "NewsTableView should be hidden at the initial state.")
    }
    
    func testNewsTableViewIsShownWhenUpdateNewsTableViewIsCalled() {
        let news = News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil)
        view.updateNewsTableView(newsList: [news])
        XCTAssertFalse(view.newsTableView.isHidden, "NewsTableView should be shown.")
    }
    
    func testNewsTableViewIsShownWhenShowErrorMessageIsCalled() {
        view.showErrorMessage(message: "")
        XCTAssertFalse(view.newsTableView.isHidden, "NewsTableView should be shown.")
    }
    
    func testTableFooterViewForNewsTableView() {
        XCTAssertEqual(view.newsTableView.tableFooterView?.frame, CGRect(x: 0, y: 0, width: 375, height: 0), "TableFooterView's frame for newsTableView shoul be zero (except width).")
    }
    
    func testEstimatedRowHeightIsSet() {
        XCTAssertNotEqual(view.newsTableView.estimatedRowHeight, 0, "EstimatedRowHeight should be set.")
    }
    
    func testProgressViewIsShownBeforeRequestPresenter() {
        XCTAssertTrue(ProgressView.shared.isShown(), "ProgressView should be shown.")
    }
    
    func testRefreshControlForNewsTableViewNotNil() {
        if #available(iOS 10.0, *) {
            XCTAssertNotNil(view.newsTableView.refreshControl, "RefreshControl should be set.")
        } else {
            XCTAssertEqual(view.refreshControl.superview, view.newsTableView, "RefreshControl should be set.")
        }
    }
    
    func testRefreshControlStatusLoading() {
        view.refreshControl.endRefreshing()
        view.refreshControl.beginRefreshing()
        XCTAssertTrue(view.refreshControl.isRefreshing, "RefreshControl should be loading.")
    }
    
    func testRefreshControlStatusEnded() {
        view.refreshControl.beginRefreshing()
        view.refreshControl.endRefreshing()
        XCTAssertFalse(view.refreshControl.isRefreshing, "RefreshControl should be ended.")
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
    
    func testSelectedBackgroundViewForNewsListCellIsSetByColorCorrectly() {
        let news = News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil)
        view.updateNewsTableView(newsList: [news])
        
        let cell = view.newsTableView.cellForRow(at: IndexPath(item: 0, section: 0))
        
        XCTAssertNotNil(cell?.selectedBackgroundView, "SelectedBackgroundView should be set.")
        XCTAssertEqual(cell?.selectedBackgroundView?.backgroundColor, UIColor(hexString: UIColor.highLightNewsListCellBackground), "SelectedBackgroundView's background color should be Blognone green.")
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
    
    func testAllOfElementsInNewsListTableViewCellAreLoaded() {
        let news = News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil)
        view.updateNewsTableView(newsList: [news])
        let cell = view.newsTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! NewsListTableViewCell
        
        XCTAssertNotNil(cell.titleLabel, "Title label should not be nil.")
        XCTAssertNotNil(cell.creatorLabel, "Creator label should not be nil.")
        XCTAssertNotNil(cell.dateTimeLabel, "DateTime label should not be nil.")
    }
    
    func testAllOfElementsInNewsListTableViewCellAreSetToNews() {
        let news = News(title: "title", link: nil, detail: "detail", pubDate: "datetime", creator: nil)
        view.updateNewsTableView(newsList: [news])
        let cell = view.newsTableView.cellForRow(at: IndexPath(item: 0, section: 0)) as! NewsListTableViewCell
        
        XCTAssertEqual(cell.titleLabel.text, news.title, "Title label should be set.")
        XCTAssertEqual(cell.creatorLabel.text, news.creator, "Creator label should be set.")
        XCTAssertEqual(cell.dateTimeLabel.text, news.pubDate, "DateTime label should be set.")
    }
    
    func testRefreshControlStatusWhenReceivedDataFromPresentorSuccess() {
        view.refreshControl.beginRefreshing()
        
        let news = News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil)
        view.updateNewsTableView(newsList: [news])
        
        XCTAssertFalse(view.refreshControl.isRefreshing, "RefreshControl should be ended.")
    }
    
    func testRefreshControlStatusWhenReceivedDataFromPresentorFail() {
        view.refreshControl.beginRefreshing()
        view.showErrorMessage(message: "")
        XCTAssertFalse(view.refreshControl.isRefreshing, "RefreshControl should be ended.")
    }
    
    func testLastUpdatedIsSetAfterReceivedDataFromPresenterSuccess() {
        let news = News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil)
        view.updateNewsTableView(newsList: [news])
        XCTAssertNotNil(view.refreshControl.attributedTitle, "Refresh date time should be set.")
    }
    
    func testRequestOpeningAboutPage() {
        view.requestOpeningAboutPage()
        XCTAssertTrue(mockPresenter.isRequestOpeningAboutPage, "RequestOpeningAboutPage should be called.")
    }

}

private class MockNewsListPresenter: NewsListPresenterProtocol, NewsListInteractorOutputProtocol {
    
    var view: NewsListViewProtocol?
    var interactor: NewsListInteractorInputProtocol?
    var wireFrame: NewsListWireFrameProtocol?
    
    var isRequestedNewsFeedData = false
    var news: News?
    var isRequestOpeningAboutPage = false
    
    func didRequestNewsFeedData() {
        isRequestedNewsFeedData = true
    }
    
    func didRequestNewsDetail(news: News) {
        self.news = news
    }
    
    func requestOpeningAboutPage(fromView view: AnyObject) {
        self.isRequestOpeningAboutPage = true
    }
    
    func didReceiveNewsFeedResult(newsFeedResult: NewsListInteractor.NewsFeedResult) {
        
    }
    
}
