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
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM d, HH:mm"
        let givenDate = formatter.date(from: givenString)
        
        // when
        let thenString = givenDate?.getStringWith(format: "MMM d, HH:mm")
        
        // then
        XCTAssertEqual(thenString, givenString, "DateTime string should be the same.")
    }
    
}
