//
//  NewsListInteractor.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

class NewsListInteractor: NewsListInteractorInputProtocol {
    
    enum NewsFeedResult {
        case success([News])
        case error(String)
    }
    
    weak var presenter: NewsListInteractorOutputProtocol?
    var apiDataManager: NewsListAPIDataManagerInputProtocol?
    
    // MARK: - NewsListInteractorInputProtocol
    
    func performGetNewsFeedTask() {
        apiDataManager?.getNewsFeed(with: { [weak self] newsFeedResult in
            self?.presenter?.didReceiveNewsFeedResult(newsFeedResult: newsFeedResult)
        })
    }
    
}
