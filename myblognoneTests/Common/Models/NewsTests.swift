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
    
    func testFormatDataForDisplay() {
        // given
        let news = News(title: nil, link: nil, detail: nil, pubDate: "Thu, 22 Dec 2016 14:34:02 +0000", creator: nil)
        let expectPubDate = "22 Dec 2016, 21:34" // GMT +7
        
        // when
        let outputNews = news.formatDataForDisplay()
        
        // then
        XCTAssertEqual(outputNews.pubDate, expectPubDate, "PubDate should be the same.")
    }
    
}
