//
//  AboutDataManager.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/26/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

class AboutDataManager: AboutDataManagerInputProtocol {
    
    func getReleaseVersionNumber() -> String {
        return Bundle.main.releaseVersionNumber ?? ""
    }
    
    func getBuildVersionNumber() -> String {
        return Bundle.main.buildVersionNumber ?? ""
    }
    
}
