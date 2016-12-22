//
//  NewsListPresenter.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

class NewsListPresenter: NewsListPresenterProtocol, NewsListInteractorOutputProtocol {
    weak var view: NewsListViewProtocol?
    var interactor: NewsListInteractorInputProtocol?
    var wireFrame: NewsListWireFrameProtocol?
    
    // MARK: - NewsListPresenterProtocol
    
    func didRequestNewsFeedData() {
        interactor?.performGetNewsFeedTask()
    }
    
    func didRequestNewsDetail(news: News) {
        wireFrame?.pushToNewsDetailInterface(news: news)
    }
    
    // MARK: - NewsListInteractorOutputProtocol
    
    func didReceiveNewsFeedResult(newsFeedResult: NewsListInteractor.NewsFeedResult) {
        switch newsFeedResult {
        case .success(let newsFeedList):
            let newsFeedListForDisplay = newsFeedList.map {
                return $0.formatDataForDisplay()
            }
            view?.updateNewsTableView(newsList: newsFeedListForDisplay)
        case .error(let msg):
            view?.showErrorMessage(message: msg)
        }
    }
    
}
