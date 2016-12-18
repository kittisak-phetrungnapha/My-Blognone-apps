//
//  NewsListWireFrame.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

class NewsListWireFrame: NewsListWireFrameProtocol {
    
    class func presentNewsListModule(fromView view: AnyObject) {
        
        // Generating module components
        var view: NewsListViewProtocol = NewsListViewController()
        var presenter: NewsListPresenterProtocol & NewsListInteractorOutputProtocol = NewsListPresenter()
        var interactor: NewsListInteractorInputProtocol = NewsListInteractor()
        var APIDataManager: NewsListAPIDataManagerInputProtocol = NewsListAPIDataManager()
        var wireFrame: NewsListWireFrameProtocol = NewsListWireFrame()
        
        // Connecting
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        
        //TODO: - Present interface(present, push)
    }
    
}
