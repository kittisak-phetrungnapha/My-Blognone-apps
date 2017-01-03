//
//  MyXCUIElementExtension.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/30/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import XCTest

extension XCUIElement {

    func scrollDownToElement(element: XCUIElement) {
        while !element.isHittable {
            swipeUp()
        }
    }
    
    func scrollUpToElement(element: XCUIElement) {
        while !element.isHittable {
            swipeDown()
        }
    }

}
