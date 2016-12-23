//
//  ProgressView.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/21/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import UIKit

class ProgressView: NSObject {

    static let shared = ProgressView()
    private var shown = false
    private var indicator: UIActivityIndicatorView!
    
    private override init() {
        indicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        indicator.startAnimating()
    }
    
    func show(in view: UIView!) {
        indicator.center = view.center
        view.addSubview(indicator)
        shown = true
    }
    
    func hide() {
        indicator.removeFromSuperview()
        shown = false
    }
    
    func isShown() -> Bool {
        return shown
    }
    
}
