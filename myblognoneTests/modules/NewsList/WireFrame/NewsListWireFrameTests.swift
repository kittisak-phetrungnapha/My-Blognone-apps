//
//  NewsListWireFrameTests.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import XCTest
import SafariServices
@testable import myblognone

class NewsListWireFrameTests: XCTestCase {
    
    private var wireframe: NewsListWireFrame!
    
    override func setUp() {
        super.setUp()
        wireframe = NewsListWireFrame()
    }
    
    override func tearDown() {
        wireframe = nil
        super.tearDown()
    }
    
    func testSetNewsListInterfaceToWindow() {
        // Given
        let window = UIWindow()
        let nav = UINavigationController()
        window.rootViewController = nav
        
        // When
        NewsListWireFrame.setNewsListInterface(to: window)
        
        // Then
        XCTAssertTrue(nav.viewControllers[0] is NewsListViewController, "NewsListViewController should be existed.")
    }
    
    func testPushToNewsDetailInterfaceWithInvalidLink() {
        // Given
        let news = News(title: nil, link: "", detail: nil, pubDate: nil, creator: nil)
        let view = UIViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = view
        
        // When
        wireframe.pushToNewsDetailInterface(news: news, viewController: view)
        
        // Then
        XCTAssertNil(view.presentedViewController, "PresentedViewController should be nil.")
    }

    func testPushToNewsDetailInterfaceWithValidLink() {
        // Given
        let news = News(title: nil, link: "https://www.facebook.com/", detail: nil, pubDate: nil, creator: nil)
        let view = UIViewController()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = view
        
        // When
        wireframe.pushToNewsDetailInterface(news: news, viewController: view)
        
        // Then
        XCTAssertTrue(view.presentedViewController is SFSafariViewController, "Presented view should be SFSafariViewController.")
    }
    
}
