//
//  AboutInteractor.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/25/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

class AboutInteractor: AboutInteractorInputProtocol {

    weak var presenter: AboutInteractorOutputProtocol?
    var dataManager: AboutDataManagerInputProtocol?

    func requestVersionAndBuildNumber() {
        let versionNumber = dataManager?.getReleaseVersionNumber()
        let buildNumber = dataManager?.getBuildVersionNumber()
        let output = "\(versionNumber!) (\(buildNumber!))"
        presenter?.didReceiveVersionAndBuildNumber(input: output)
    }
    
}
