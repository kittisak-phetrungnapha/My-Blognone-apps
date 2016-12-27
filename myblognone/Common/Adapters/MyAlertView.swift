//
//  MyAlertView.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/21/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import UIKit
import RKDropdownAlert

class MyAlertView: NSObject {

    static let shared = MyAlertView()
    let displayTime = 3
    
    private override init() { }
    
    func showWithTitle(title: String, message: String?) {
        if let message = message {
            RKDropdownAlert.title(title, message: message, backgroundColor: UIColor(hexString: UIColor.errorViewBackground), textColor: UIColor.white, time: displayTime)
            return
        }
        
        RKDropdownAlert.title(title, backgroundColor: UIColor(hexString: UIColor.errorViewBackground), textColor: UIColor.white, time: displayTime)
    }
    
}
