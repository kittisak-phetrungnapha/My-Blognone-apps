//
//  NewsListAPIDataManager.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

class NewsListAPIDataManager: NewsListAPIDataManagerInputProtocol {
    
    private let NEWS_FEED_API = "https://www.blognone.com/atom.xml"
    
    enum NewsFeedResult {
        case success([News])
        case error(String)
    }
    
    func getNewsFeed(with completion: @escaping (NewsFeedResult) -> Void) {
        var request = URLRequest(url: URL(string: NEWS_FEED_API)!)
        request.httpMethod = "GET"
        request.timeoutInterval = 10
        
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
            
            DispatchQueue.main.async {
                var newsFeedList = [News]()
                newsFeedList.append(News(title: nil, link: nil, detail: nil, pubDate: nil, creator: nil))
                completion(.success(newsFeedList))
            }
            
            }.resume()
    }
    
}
