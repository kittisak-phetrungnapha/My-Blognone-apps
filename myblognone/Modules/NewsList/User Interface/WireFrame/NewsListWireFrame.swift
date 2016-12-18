//
//  NewsListWireFrame.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import UIKit

class NewsListWireFrame: NewsListWireFrameProtocol {
    
    static let NewsListViewControllerIdentifier = "NewsListViewController"
    
    // MARK: - NewsListWireFrameProtocol
    
    class func setNewsListInterface(to window: AnyObject) {
        let storyboard = UIStoryboard(name: "NewsList", bundle: Bundle.main)
        
        // Generating module components
        let view = storyboard.instantiateViewController(withIdentifier: NewsListViewControllerIdentifier) as! NewsListViewController
        let presenter: NewsListPresenterProtocol & NewsListInteractorOutputProtocol = NewsListPresenter()
        let interactor: NewsListInteractorInputProtocol = NewsListInteractor()
        let apiDataManager: NewsListAPIDataManagerInputProtocol = NewsListAPIDataManager()
        let wireFrame: NewsListWireFrameProtocol = NewsListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.apiDataManager = apiDataManager
        
        // set to root navigation controller
        if let window = window as? UIWindow, let nav = window.rootViewController as? UINavigationController {
            nav.viewControllers = [view]
        }
    }
    
    func pushToNewsDetailInterface(news: News) {
        
    }
    
}
