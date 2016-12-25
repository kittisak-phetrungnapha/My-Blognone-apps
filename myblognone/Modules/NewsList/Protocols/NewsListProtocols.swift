//
//  NewsListProtocols.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

protocol NewsListViewProtocol: class {
    var presenter: NewsListPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func updateNewsTableView(newsList: [News])
    func showErrorMessage(message: String)
}

protocol NewsListWireFrameProtocol: class {
    static func setNewsListInterface(to window: AnyObject)
    
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func pushToNewsDetailInterface(news: News, viewController: AnyObject?)
    func pushToAboutInterface(fromView view: AnyObject)
}

protocol NewsListPresenterProtocol: class {
    var view: NewsListViewProtocol? { get set }
    var interactor: NewsListInteractorInputProtocol? { get set }
    var wireFrame: NewsListWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func didRequestNewsFeedData()
    func didRequestNewsDetail(news: News)
    func requestOpeningAboutPage(fromView view: AnyObject)
}

protocol NewsListInteractorOutputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func didReceiveNewsFeedResult(newsFeedResult: NewsListInteractor.NewsFeedResult)
}

protocol NewsListInteractorInputProtocol: class {
    var presenter: NewsListInteractorOutputProtocol? { get set }
    var apiDataManager: NewsListAPIDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func performGetNewsFeedTask()
}

protocol NewsListAPIDataManagerInputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> APIDATAMANAGER
    */
    func getNewsFeed(with completion: @escaping (NewsListInteractor.NewsFeedResult) -> Void)
}
