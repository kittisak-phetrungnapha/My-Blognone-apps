//
//  MyXCTestCaseExtension.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/31/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {
    
    func waitForElementToAppear(element: XCUIElement, timeout: TimeInterval = 15, file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        
        expectation(for: existsPredicate,
                    evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: line, expected: true)
            }
        }
    }
    
    func waitForElementToDisAppear(element: XCUIElement, timeout: TimeInterval = 15, file: String = #file, line: UInt = #line) {
        let notExistsPredicate = NSPredicate(format: "exists == false")
        
        expectation(for: notExistsPredicate,
                    evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to remove \(element) after \(timeout) seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: line, expected: true)
            }
        }
    }
    
}
