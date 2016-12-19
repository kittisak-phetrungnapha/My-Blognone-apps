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
    
    func testPerformNewsFeedTask() {
        interactor.apiDataManager?.getNewsFeed(with: { newsFeedResult in
            self.interactor.presenter?.didReceiveNewsFeedResult(newsFeedResult: newsFeedResult)
            XCTAssertNotNil(self.mockPresenter.newsFeedResult, "NewsFeedResult should not be nil.")
        })
    }
    
}

class MockNewsListPresenter: NewsListPresenterProtocol, NewsListInteractorOutputProtocol {
    
    var view: NewsListViewProtocol?
    var interactor: NewsListInteractorInputProtocol?
    var wireFrame: NewsListWireFrameProtocol?
    
    var newsFeedResult: NewsListInteractor.NewsFeedResult?
    
    func didRequestNewsFeedData() {
        
    }
    
    func didRequestNewsDetail(news: News) {
        
    }
    
    func didReceiveNewsFeedResult(newsFeedResult: NewsListInteractor.NewsFeedResult) {
        self.newsFeedResult = newsFeedResult
    }
    
}

class MockNewsListAPIDataManager: NewsListAPIDataManagerInputProtocol {
    
    func getNewsFeed(with completion: @escaping (NewsListInteractor.NewsFeedResult) -> Void) {
        // It doesn't matter return success or failure case.
        completion(.success([News]()))
    }
    
}
