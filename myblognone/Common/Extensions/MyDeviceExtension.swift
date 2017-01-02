//
//  MyDeviceExtension.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 1/2/2560 BE.
//  Copyright © 2560 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import UIKit

extension UIDevice {
    
    static func isIPhone() -> Bool {
        return UIScreen.main.traitCollection.userInterfaceIdiom == .phone
    }
    
    static func isIPad() -> Bool {
        return UIScreen.main.traitCollection.userInterfaceIdiom == .pad
    }
    
}
