//
//  ProgressView.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/21/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProgressView: NSObject {

    static let shared = ProgressView()
    private var shown = false
    
    private override init() {}
    
    func show() {
        SVProgressHUD.show()
        shown = true
    }
    
    func hide() {
        SVProgressHUD.dismiss()
        shown = false
    }
    
    func isShown() -> Bool {
        return shown
    }
    
}
