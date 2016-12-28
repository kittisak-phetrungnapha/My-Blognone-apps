//
//  AboutProtocols.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

protocol AboutViewProtocol: class {
    var presenter: AboutPresenterProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> VIEW
    */
    func setupVersionAndBuildNumber(input: String)
}

protocol AboutWireFrameProtocol: class {
    static func presentAboutModule(fromView view: AnyObject)
    /**
    * Add here your methods for communication PRESENTER -> WIREFRAME
    */
    func openMailApp()
    func openAppStore()
}

protocol AboutPresenterProtocol: class {
    var view: AboutViewProtocol? { get set }
    var interactor: AboutInteractorInputProtocol? { get set }
    var wireFrame: AboutWireFrameProtocol? { get set }
    /**
    * Add here your methods for communication VIEW -> PRESENTER
    */
    func didRequestVersionAndBuildNumber()
    func didRequestSendEmailFeedback()
    func didRequestRateThisApps()
}

protocol AboutInteractorOutputProtocol: class {
    /**
    * Add here your methods for communication INTERACTOR -> PRESENTER
    */
    func didReceiveVersionAndBuildNumber(input: String)
}

protocol AboutInteractorInputProtocol: class {
    var presenter: AboutInteractorOutputProtocol? { get set }
    var dataManager: AboutDataManagerInputProtocol? { get set }
    /**
    * Add here your methods for communication PRESENTER -> INTERACTOR
    */
    func requestVersionAndBuildNumber()
}

protocol AboutDataManagerInputProtocol: class {
    /**
     * Add here your methods for communication INTERACTOR -> DATAMANAGER
     */
    func getReleaseVersionNumber() -> String
    func getBuildVersionNumber() -> String
}
