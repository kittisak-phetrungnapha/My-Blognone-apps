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

    
    
}

class MockInteractor: NewsListInteractorInputProtocol {
 
    var presenter: NewsListInteractorOutputProtocol?
    var apiDataManager: NewsListAPIDataManagerInputProtocol?
    
    func performGetNewsFeedTask() {
        
    }
    
}

class MockWireframe: NewsListWireFrameProtocol {
    
    static func setNewsListInterface(to window: AnyObject) {
        
    }
    
    func pushToNewsDetailInterface() {
        
    }
    
}

class MockViewController: NewsListViewProtocol {
    
    var presenter: NewsListPresenterProtocol?
    
    func setupInitialState() {
        
    }
    
    func updateNewsTableView(newsList: [News]) {
        
    }
    
    func showErrorMessage(message: String) {
        
    }
    
}
