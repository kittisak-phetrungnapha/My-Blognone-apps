//
//  MyDateExtensionTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/22/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class MyDateExtensionTests: XCTestCase {
    
    func testGetStringWithValidFormat() {
        // given
        let givenString = "Dec 22, 21:25"
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(secondsFromGMT: 25200)
        formatter.dateFormat = "MMM d, HH:mm"
        let givenDate = formatter.date(from: givenString)
        
        // when
        let thenString = givenDate?.getStringWith(format: "MMM d, HH:mm")
        
        // then
        XCTAssertEqual(thenString, givenString, "DateTime string should be the same.")
    }
    
    func testGetNewDateTimeStringWithValidInputs() {
        // given
        let inputString = "Thu, 22 Dec 2016 14:34:02 +0000"
        let inputFormat = "EEE, dd MMM yyyy HH:mm:ss VVVV"
        let outputFormat = "dd MMM yyyy, HH:mm"
        let expectOutput = "22 Dec 2016, 21:34" // GMT +7
        
        // when
        let outputString = Date.getNewDateTimeString(inputStr: inputString, inputFormat: inputFormat, outputFormat: outputFormat)
        
        // then
        XCTAssertEqual(outputString, expectOutput, "Output string should be the same.")
    }
    
    func testGetNewDateTimeStringWithInValidInputs() {
        var inputString = ""
        var inputFormat = "EEE, dd MMM yyyy HH:mm:ss VVVV"
        let outputFormat = "dd MMM yyyy, HH:mm"
        
        // when
        var outputString = Date.getNewDateTimeString(inputStr: inputString, inputFormat: inputFormat, outputFormat: outputFormat)
        
        // then
        XCTAssertNil(outputString, "Output string should be nil.")
        
        // given
        inputString = "Thu, 22 Dec 2016 14:34:02 +0000"
        inputFormat = ""
        
        // when
        outputString = Date.getNewDateTimeString(inputStr: inputString, inputFormat: inputFormat, outputFormat: outputFormat)
        
        // then
        XCTAssertNil(outputString, "Output string should be nil.")
    }
    
}
