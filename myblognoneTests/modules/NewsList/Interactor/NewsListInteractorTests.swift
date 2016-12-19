//
//  NewsListInteractorTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class NewsListInteractorTests: XCTestCase, NewsListInteractorOutputProtocol {
    
    private var interactor: NewsListInteractor!
    private var newsFeedResult: NewsListInteractor.NewsFeedResult?
    
    override func setUp() {
        super.setUp()
        
        interactor = NewsListInteractor()
        interactor.presenter = self
        let mockApiDataManager = MockNewsListAPIDataManager()
        interactor.apiDataManager = mockApiDataManager
    }
    
    override func tearDown() {
        interactor = nil
        newsFeedResult = nil
        
        super.tearDown()
    }
    
    func testPerformNewsFeedTask() {
        interactor.apiDataManager?.getNewsFeed(with: { newsFeedResult in
            self.interactor.presenter?.didReceiveNewsFeedResult(newsFeedResult: newsFeedResult)
            XCTAssertNotNil(self.newsFeedResult, "NewsFeedResult should not be nil.")
        })
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
