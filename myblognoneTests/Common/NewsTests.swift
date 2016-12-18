//
//  NewsTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
@testable import myblognone

class NewsTests: XCTestCase {
    
    func testCreateNewsWithNilValueShouldBeReplacedWithEmptyValue() {
        let news = News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil)
        
        XCTAssertEqual(news.title, "", "Title should be equal empty.")
        XCTAssertEqual(news.link, "", "Link should be equal empty.")
        XCTAssertEqual(news.detail, "", "Detail should be equal empty.")
        XCTAssertEqual(news.pubDate, "", "PubDate should be equal empty.")
        XCTAssertEqual(news.creator, "", "Create should be equal empty.")
    }
    
}
