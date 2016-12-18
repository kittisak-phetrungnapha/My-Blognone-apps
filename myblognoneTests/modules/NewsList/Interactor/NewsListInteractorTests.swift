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
    
    func testGetNewsFeed() {
        let asyncExpectation = expectation(description: "getNewsFeedTask")
        let apiDataManager = NewsListAPIDataManager()
        
        var newsFeedList: [News]?
        var errorMsg: String?
        apiDataManager.getNewsFeed(with: { newsFeedResult in
            switch newsFeedResult {
            case .success(let newsList):
                newsFeedList = newsList
            case .error(let msg):
                errorMsg = msg
            }
            asyncExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 10, handler: { error in
            XCTAssertNil(error, "Something went horribly wrong.")
            XCTAssertNil(errorMsg, "Error message should be nil.")
            XCTAssertNotNil(newsFeedList, "News feed list shoud not be nil.")
            XCTAssertEqual(newsFeedList?.count, 15, "News feed list should contain 15 elements.")
        })
    }
    
}

class MockPresenter: NewsListInteractorInputProtocol {
    var presenter: NewsListInteractorOutputProtocol?
    var apiDataManager: NewsListAPIDataManagerInputProtocol?
    
    func performGetNewsFeedTask() {
        
    }
}
