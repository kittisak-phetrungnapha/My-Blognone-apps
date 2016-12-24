//
//  NewsListAPIDataManager.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation
import AEXML

class NewsListAPIDataManager: NewsListAPIDataManagerInputProtocol {
    
    private let NEWS_FEED_API = "https://www.blognone.com/atom.xml"
    
    // MARK: - NewsListAPIDataManagerInputProtocol
    
    func getNewsFeed(with completion: @escaping (NewsListInteractor.NewsFeedResult) -> Void) {
        var request = URLRequest(url: URL(string: NEWS_FEED_API)!)
        request.httpMethod = "GET"
        request.timeoutInterval = 15
        
        URLSession.shared.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.error(error.localizedDescription))
                }
                return
            }
            
            guard let response = response, let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 else {
                    DispatchQueue.main.async {
                        completion(.error(NSLocalizedString("unknown_error_text", comment: "")))
                    }
                    return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    completion(.error(NSLocalizedString("unknown_error_text", comment: "")))
                }
                return
            }
            
            // Parse xml data
            do {
                let xmlDoc = try AEXMLDocument(xml: data)
                guard let items = xmlDoc.root["channel"]["item"].all else {
                    DispatchQueue.main.async {
                        completion(.error(NSLocalizedString("parse_xml_data_error_text", comment: "")))
                    }
                    return
                }
                
                var newsFeedList = [News]()
                for item in items {
                    let title = item["title"].value
                    let link = item["link"].value
//                    let detail = item["description"].value
                    let pubDate = item["pubDate"].value
                    let creator = item["dc:creator"].value
                    
                    let news = News(title: title, link: link, detail: "", pubDate: pubDate, creator: creator)
                    newsFeedList.append(news)
                }
                
                DispatchQueue.main.async {
                    completion(.success(newsFeedList))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.error(error.localizedDescription))
                }
            }
            
            }.resume()
    }
    
}
