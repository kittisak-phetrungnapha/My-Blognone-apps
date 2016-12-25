//
//  AboutWireFrame.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import UIKit

class AboutWireFrame: AboutWireFrameProtocol {
    
    static let AboutViewControllerIdentifier = "AboutViewController"
    static let StoryboardIdentifier = "About"
    
    static func presentAboutModule(fromView view: AnyObject) {
        let storyboard = UIStoryboard(name: StoryboardIdentifier, bundle: Bundle.main)
        
        // Generating module components 
        let aboutView = storyboard.instantiateViewController(withIdentifier: AboutViewControllerIdentifier) as! AboutViewController
        let presenter: AboutPresenterProtocol & AboutInteractorOutputProtocol = AboutPresenter()
        let interactor: AboutInteractorInputProtocol = AboutInteractor()
        let APIDataManager: AboutAPIDataManagerInputProtocol = AboutAPIDataManager()
        let localDataManager: AboutLocalDataManagerInputProtocol = AboutLocalDataManager()
        let wireFrame: AboutWireFrameProtocol = AboutWireFrame()
        
        // Connecting
        aboutView.presenter = presenter
        presenter.view = aboutView
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.APIDataManager = APIDataManager
        interactor.localDatamanager = localDataManager
        
        // Push
        if let nav = view as? UINavigationController {
            nav.pushViewController(aboutView, animated: true)
        }
    }
    
}
