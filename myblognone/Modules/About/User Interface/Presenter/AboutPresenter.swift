//
//  AboutPresenter.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

class AboutPresenter: AboutPresenterProtocol, AboutInteractorOutputProtocol {
    weak var view: AboutViewProtocol?
    var interactor: AboutInteractorInputProtocol?
    var wireFrame: AboutWireFrameProtocol?
    
    func didRequestVersionAndBuildNumber() {
        interactor?.requestVersionAndBuildNumber()
    }
    
    func didReceiveVersionAndBuildNumber(input: String) {
        view?.setupVersionAndBuildNumber(input: input)
    }
    
    func didRequestSendEmailFeedback() {
        wireFrame?.openMailApp()
    }
    
    func didRequestRateThisApps() {
        wireFrame?.openAppStore()
    }
    
}
