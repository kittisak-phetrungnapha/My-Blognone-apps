//
//  NewsListAPIDataManagerTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
import Mockingjay
@testable import myblognone

class NewsListAPIDataManagerTests: XCTestCase {
    
    func testGetNewsFeedAsyncFailWithStatusCodeNot200() {
        stub(everything, http(404))
        
        let asyncExpectation = expectation(description: "getNewsFeedTask")
        let apiDataManager = NewsListAPIDataManager()
        
        var errorMsg: String?
        apiDataManager.getNewsFeed(with: { newsFeedResult in
            switch newsFeedResult {
            case .error(let msg):
                errorMsg = msg
            default: break
            }
            asyncExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 15, handler: { error in
            XCTAssertNil(error, "Something went horribly wrong.")
            XCTAssertNotNil(errorMsg, "Error message should not be nil.")
        })
    }
    
    func testGetNewsFeedAsyncFailWithError() {
        stub(everything, failure(NSError(domain: "blognone.com", code: 500, userInfo: nil)))
        
        let asyncExpectation = expectation(description: "getNewsFeedTask")
        let apiDataManager = NewsListAPIDataManager()
        
        var errorMsg: String?
        apiDataManager.getNewsFeed(with: { newsFeedResult in
            switch newsFeedResult {
            case .error(let msg):
                errorMsg = msg
            default: break
            }
            asyncExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 15, handler: { error in
            XCTAssertNil(error, "Something went horribly wrong.")
            XCTAssertNotNil(errorMsg, "Error message should not be nil.")
        })
    }
    
    func testGetNewsFeedAsyncSuccessButParseXmlFail() {
        stub(everything, json(["xml": "wrong_xml"]))
        
        let asyncExpectation = expectation(description: "getNewsFeedTask")
        let apiDataManager = NewsListAPIDataManager()
        
        var errorMsg: String?
        apiDataManager.getNewsFeed(with: { newsFeedResult in
            switch newsFeedResult {
            case .error(let msg):
                errorMsg = msg
            default: break
            }
            asyncExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 15, handler: { error in
            XCTAssertNil(error, "Something went horribly wrong.")
            XCTAssertNotNil(errorMsg, "Error message should not be nil.")
        })
    }
    
    func testGetNewsFeedAsyncSuccessButInvalidXmlNode() {
        let path = Bundle(for: type(of: self)).path(forResource: "mock_for_missing_node", ofType: "xml")!
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            stub(everything, jsonData(data))
            
            let asyncExpectation = expectation(description: "getNewsFeedTask")
            let apiDataManager = NewsListAPIDataManager()
            
            var errorMsg: String?
            apiDataManager.getNewsFeed(with: { newsFeedResult in
                switch newsFeedResult {
                case .error(let msg):
                    errorMsg = msg
                default: break
                }
                asyncExpectation.fulfill()
            })
            
            waitForExpectations(timeout: 15, handler: { error in
                XCTAssertNil(error, "Something went horribly wrong.")
                XCTAssertNotNil(errorMsg, "Error message should not be nil.")
            })
        } catch {
            XCTAssert(false, "Found error: \(error.localizedDescription)")
        }
    }
    
    func testGetNewsFeedAsync() {
        let asyncExpectation = expectation(description: "getNewsFeedTask")
        let apiDataManager = NewsListAPIDataManager()
        
        var newsFeedList: [News]?
        apiDataManager.getNewsFeed(with: { newsFeedResult in
            switch newsFeedResult {
            case .success(let newsList):
                newsFeedList = newsList
            default: break
            }
            asyncExpectation.fulfill()
        })
        
        waitForExpectations(timeout: 15, handler: { error in
            XCTAssertNil(error, "Something went horribly wrong.")
            XCTAssertEqual(newsFeedList?.count, 15, "News feed list should contain 15 elements.")
        })
    }
    
}
