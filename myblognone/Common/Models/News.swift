//
//  News.swift
//  myblognone
//
//  Created by Kittisak Phetrungnapha on 12/18/2559 BE.
//  Copyright © 2559 Kittisak Phetrungnapha. All rights reserved.
//

import Foundation

struct News {
    let title: String
    let link: String
    let detail: String
    var pubDate: String!
    let creator: String
    
    init(title: String?, link: String?, detail: String?, pubDate: String?, creator: String?) {
        self.title = title ?? ""
        self.link = link ?? ""
        self.detail = detail ?? ""
        self.pubDate = pubDate ?? ""
        self.creator = creator ?? ""
    }
    
    func formatDataForDisplay() -> News {
        var newsOutput = self
        newsOutput.pubDate = Date.getNewDateTimeString(inputStr: pubDate, inputFormat: "EEE, dd MMM yyyy HH:mm:ss ZZZZ", outputFormat: "dd MMM yyyy, HH:mm")
        return newsOutput
    }
    
}
