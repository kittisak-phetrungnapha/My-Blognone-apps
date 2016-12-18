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
    
    override func setUp() {
        super.setUp()
        
        interactor = NewsListInteractor()
        let mockPresenter = MockNewsListPresenter()
        interactor.presenter = mockPresenter
    }
    
    override func tearDown() {
        interactor = nil
        
        super.tearDown()
    }
    
    func testPerformNewsFeedTaskSuccess() {
        let mockApiDataManager = MockNewsListAPIDataManager(wantSuccess: true)
        interactor.apiDataManager = mockApiDataManager
        
        interactor.apiDataManager?.getNewsFeed(with: { newsFeedResult in
            self.interactor.presenter?.didReceiveNewsFeedResult(newsFeedResult: newsFeedResult)
            
            switch newsFeedResult {
            case .success(_):
                XCTAssertTrue(true)
            case .error(_):
                XCTAssertTrue(false, "NewsFeedResult should be true case.")
            }
        })
    }
    
    func testPerformNewsFeedTaskFail() {
        let mockApiDataManager = MockNewsListAPIDataManager(wantSuccess: false)
        interactor.apiDataManager = mockApiDataManager
        
        interactor.apiDataManager?.getNewsFeed(with: { newsFeedResult in
            self.interactor.presenter?.didReceiveNewsFeedResult(newsFeedResult: newsFeedResult)
            
            switch newsFeedResult {
            case .success(_):
                XCTAssertFalse(true, "NewsFeedResult should be false case.")
            case .error(_):
                XCTAssertFalse(false)
            }
        })
    }
    
}

class MockNewsListPresenter: NewsListPresenterProtocol, NewsListInteractorOutputProtocol {
    weak var view: NewsListViewProtocol?
    var interactor: NewsListInteractorInputProtocol?
    var wireFrame: NewsListWireFrameProtocol?
    
    func didRequestNewsFeedData() {
        
    }
    
    func didRequestNewsDetail(news: News) {
        
    }
    
    func didReceiveNewsFeedResult(newsFeedResult: NewsListInteractor.NewsFeedResult) {
        
    }
    
}

class MockNewsListAPIDataManager: NewsListAPIDataManagerInputProtocol {
    
    private var wantSuccess: Bool
    
    init(wantSuccess: Bool) {
        self.wantSuccess = wantSuccess
    }
    
    func getNewsFeed(with completion: @escaping (NewsListInteractor.NewsFeedResult) -> Void) {
        if wantSuccess {
            completion(.success([News]()))
        }
        else {
            completion(.error("Dummy error get news feed data."))
        }
    }
    
}
