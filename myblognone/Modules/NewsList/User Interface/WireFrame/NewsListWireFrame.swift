//
//  NewsListWireFrame.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class NewsListWireFrame: NewsListWireFrameProtocol {
    
    static let NewsListViewControllerIdentifier = "NewsListViewController"
    static let StoryboardIdentifier = "NewsList"
    
    // MARK: - NewsListWireFrameProtocol
    
    class func setNewsListInterface(to window: AnyObject) {
        let storyboard = UIStoryboard(name: StoryboardIdentifier, bundle: Bundle.main)
        
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
    
    func pushToNewsDetailInterface(news: News, viewController: AnyObject?) {
        guard let view = viewController as? UIViewController, let url = URL(string: news.link)
            else {
                return
        }
        
        let svc = SFSafariViewController(url: url, entersReaderIfAvailable: true)
        if #available(iOS 10.0, *) {
            svc.preferredBarTintColor = UIColor(hexString: UIColor.navigationBarBackground) ?? UIColor.defaultNavigationBarColor()
            svc.preferredControlTintColor = UIColor.white
        }
        else {
            UIApplication.shared.statusBarStyle = .default
        }
        view.present(svc, animated: true, completion: nil)
    }
    
    func pushToAboutInterface(fromView view: AnyObject) {
        AboutWireFrame.presentAboutModule(fromView: view)
    }
    
}
