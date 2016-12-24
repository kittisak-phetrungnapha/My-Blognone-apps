//
//  NewsListInteractorTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class NewsListInteractorTests: XCTestCase {
    
    private var interactor: NewsListInteractor!
    private var mockPresenter: MockNewsListPresenter!
    
    override func setUp() {
        super.setUp()
        
        interactor = NewsListInteractor()
        mockPresenter = MockNewsListPresenter()
        interactor.presenter = mockPresenter
        
        let mockApiDataManager = MockNewsListAPIDataManager()
        interactor.apiDataManager = mockApiDataManager
    }
    
    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        
        super.tearDown()
    }
    
    func testGetNewsFeed() {
        interactor.apiDataManager?.getNewsFeed(with: { newsFeedResult in
            XCTAssertNotNil(newsFeedResult, "NewsFeedResult should not be nil.")
        })
    }
    
    func testPerformNewsFeedTaskSuccess() {
        let successResult = NewsListInteractor.NewsFeedResult.success([News]())
        self.interactor.presenter?.didReceiveNewsFeedResult(newsFeedResult: successResult)
        XCTAssertTrue(self.mockPresenter.isSuccess ?? false, "NewsFeedResult should be successful case.")
    }
    
    func testPerformNewsFeedTaskFail() {
        let failResult = NewsListInteractor.NewsFeedResult.error("Dummy error")
        self.interactor.presenter?.didReceiveNewsFeedResult(newsFeedResult: failResult)
        XCTAssertFalse(self.mockPresenter.isSuccess ?? true, "NewsFeedResult should be failure case.")
    }
    
}

private class MockNewsListPresenter: NewsListPresenterProtocol, NewsListInteractorOutputProtocol {
    
    var view: NewsListViewProtocol?
    var interactor: NewsListInteractorInputProtocol?
    var wireFrame: NewsListWireFrameProtocol?
    
    var isSuccess: Bool?
    
    func didRequestNewsFeedData() {
        
    }
    
    func didRequestNewsDetail(news: News) {
        
    }
    
    func requestOpeningAboutPage() {
        
    }
    
    func didReceiveNewsFeedResult(newsFeedResult: NewsListInteractor.NewsFeedResult) {
        switch newsFeedResult {
        case .success(_):
            isSuccess = true
        case .error(_):
            isSuccess = false
        }
    }
    
}

private class MockNewsListAPIDataManager: NewsListAPIDataManagerInputProtocol {
    
    func getNewsFeed(with completion: @escaping (NewsListInteractor.NewsFeedResult) -> Void) {
        // It doesn't matter return success or failure case.
        completion(.success([News]()))
    }
    
}
