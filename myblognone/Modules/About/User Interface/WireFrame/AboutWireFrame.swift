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
    
    private let emailForFeedback = "cs.sealsoul@gmail.com"
    private let appStoreUrl = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?id=1191248877&onlyLatestVersion=true&pageNumber=0&sortOrdering=1&type=Purple+Software"
    
    static func presentAboutModule(fromView view: AnyObject) {
        let storyboard = UIStoryboard(name: StoryboardIdentifier, bundle: Bundle.main)
        
        // Generating module components 
        let aboutView = storyboard.instantiateViewController(withIdentifier: AboutViewControllerIdentifier) as! AboutViewController
        let presenter: AboutPresenterProtocol & AboutInteractorOutputProtocol = AboutPresenter()
        let interactor: AboutInteractorInputProtocol = AboutInteractor()
        let wireFrame: AboutWireFrameProtocol = AboutWireFrame()
        let dataManager = AboutDataManager()
        
        // Connecting
        aboutView.presenter = presenter
        presenter.view = aboutView
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.dataManager = dataManager
        
        // Push
        if let nav = view as? UINavigationController {
            nav.pushViewController(aboutView, animated: true)
        }
    }
    
    func openMailApp() {
        guard let url = URL(string: "mailto:\(emailForFeedback)") else { return }
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func openAppStore() {
        guard let url = URL(string: appStoreUrl) else { return }
        
        if #available(iOS 10, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
}
