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
    private var mockApiDataManager: MockNewsListAPIDataManager!
    
    override func setUp() {
        super.setUp()
        
        interactor = NewsListInteractor()
        mockPresenter = MockNewsListPresenter()
        interactor.presenter = mockPresenter
        
        mockApiDataManager = MockNewsListAPIDataManager()
        interactor.apiDataManager = mockApiDataManager
    }
    
    override func tearDown() {
        interactor = nil
        mockPresenter = nil
        mockApiDataManager = nil
        
        super.tearDown()
    }
    
    func testPerformNewsFeedTaskSuccess() {
        // Given
        mockApiDataManager.wantSuccess = true
        
        // When
        interactor.performGetNewsFeedTask()
        
        // Then
        XCTAssertNotNil(self.mockPresenter.newsList, "NewsList should not be nil.")
    }
    
    func testPerformNewsFeedTaskFail() {
        // Given
        mockApiDataManager.wantSuccess = false
        
        // When
        interactor.performGetNewsFeedTask()
        
        // Then
        XCTAssertNotNil(self.mockPresenter.errorMessage, "ErrorMessage should not be nil.")
    }
    
}

private class MockNewsListPresenter: NewsListPresenterProtocol, NewsListInteractorOutputProtocol {
    
    var view: NewsListViewProtocol?
    var interactor: NewsListInteractorInputProtocol?
    var wireFrame: NewsListWireFrameProtocol?
    
    var newsList: [News]?
    var errorMessage: String?
    
    func didRequestNewsFeedData() {
        
    }
    
    func didRequestNewsDetail(news: News) {
        
    }
    
    func requestOpeningAboutPage(fromView view: AnyObject) {
        
    }
    
    func didReceiveNewsFeedResult(newsFeedResult: NewsListInteractor.NewsFeedResult) {
        switch newsFeedResult {
        case .success(let newsList):
            self.newsList = newsList
        case .error(let errorMessage):
            self.errorMessage = errorMessage
        }
    }
    
}

private class MockNewsListAPIDataManager: NewsListAPIDataManagerInputProtocol {
    
    var wantSuccess = false
    
    func getNewsFeed(with completion: @escaping (NewsListInteractor.NewsFeedResult) -> Void) {
        if wantSuccess {
            completion(.success([News]()))
        }
        else {
            completion(.error(""))
        }
    }
    
}
