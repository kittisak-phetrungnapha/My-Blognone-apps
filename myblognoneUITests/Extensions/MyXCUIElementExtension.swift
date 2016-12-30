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
        while !element.visible() {
            swipeUp()
        }
    }
    
    func scrollUpToElement(element: XCUIElement) {
        while !element.visible() {
            swipeDown()
        }
    }

    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }

}
