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
        wireFrame?.pushToNewsDetailInterface()
    }
    
    // MARK: - NewsListInteractorOutputProtocol
    
    func didReceiveNewsFeedResult(newsFeedResult: NewsListInteractor.NewsFeedResult) {
        switch newsFeedResult {
        case .success(let newsFeedList):
            view?.updateNewsTableView(newsList: newsFeedList)
        case .error(let msg):
            view?.showErrorMessage(message: msg)
        }
    }
    
}
